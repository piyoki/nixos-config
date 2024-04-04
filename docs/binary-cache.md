# Minio Nix Binary Cache Setup

<!-- vim-markdown-toc GFM -->

* [References](#references)
* [Setup](#setup)
  * [Generate password](#generate-password)
  * [Setup minio-client](#setup-minio-client)
  * [Setup policy](#setup-policy)
  * [Setup binary cache](#setup-binary-cache)
  * [Generate key pairs](#generate-key-pairs)
  * [Activate binary cache with flake](#activate-binary-cache-with-flake)
  * [Push paths to the store](#push-paths-to-the-store)
  * [Add automatic object expiration policy](#add-automatic-object-expiration-policy)

<!-- vim-markdown-toc -->

## References

- [NixOS Binary Cache 2022](https://jcollie.github.io/nixos/2022/04/27/nixos-binary-cache-2022.html)
- [Minio Automatic Object Expiration](https://min.io/docs/minio/linux/administration/object-management/create-lifecycle-management-expiration-rule.html)
- [NixOS Wiki - Binary Cache](https://nixos.wiki/wiki/Binary_Cache)

## Setup

### Generate password

```bash
pwgen -c -n -y -s -B 32 1
# oenu1Yuch3rohz2ahveid0koo4giecho
```

### Setup minio-client

Install the minio command line client `mc`. Create or edit ~/.mc/config.json

```json
{
  "version": "10",
  "aliases": {
    "s3": {
      "url": "https://s3.homelab.local",
      "accessKey": "minio",
      "secretKey": "oenu1Yuch3rohz2ahveid0koo4giecho",
      "api": "s3v4",
      "path": "auto"
    }
  }
}
```

### Setup policy

Create a file called `nix-cache-write.json` with the following contents:

```json
{
  "Id": "AuthenticatedWrite",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AuthenticatedWrite",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:ListMultipartUploadParts",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::nix-cache", "arn:aws:s3:::nix-cache/*"],
      "Principal": "nixbuilder"
    }
  ]
}
```

### Setup binary cache

Create a file called `nix-cache-info` with the following contents:

```
StoreDir: /nix/store
WantMassQuery: 1
Priority: 40
```

Create the nix-cache bucket

```bash
mc mb s3/nix-cache
```

Create the `nixbuilder` minio user and assign a password

```bash
mc admin user add s3 nixbuilder <PASSWORD>
```

Create a policy that will allow nixbuilder to upload files to the cache

```bash
mc admin policy add s3 nix-cache-write nix-cache-write.json
```

Associate the policy that we created above with the nixbuilder user

```bash
mc admin policy set s3 nix-cache-write user=nixbuilder
```

Allow anonymous users to download files without authenticing

```bash
mc anonymous set download minio/nix-cache
```

Copy nix-cache-info to the cache. This file tells nix that this is indeed a binary cache

```bash
mc cp ./nix-cache-info s3/nix-cache/nix-cache-info
```

### Generate key pairs

Generate a secret and public key for signing store paths. The key name is arbitrary but the NixOS developers highly recommend using the domain name of the cache followed by an integer. If the key ever needs to be revoked or regenerated the trailing integer can be incremented

```bash
nix key generate-secret --key-name s3.homelab.local-1 > ~/.config/nix/secret.key
nix key convert-secret-to-public < ~/.config/nix/secret.key > ~/.config/nix/public.key
cat ~/.config/nix/public.key
s3.homelab.local-1:m0J/oDlLEuG6ezc6MzmpLCN2MYjssO3NMIlr9JdxkTs=
```

### Activate binary cache with flake

```nix
{
  nix = {
    settings = {
      # substituers will be appended to the default substituters when fetching packages
      extra-substituters = [
        "https://s3.homelab.local/nix-cache/"
      ];
      extra-trusted-public-keys = [
        "s3.homelab.local-1:m0J/oDlLEuG6ezc6MzmpLCN2MYjssO3NMIlr9JdxkTs="
      ];
    };
  };
}
```

Rebuild the system

```bash
sudo nixos-rebuild switch --upgrade --flake .#<HOST>
```

### Push paths to the store

Sign some paths in the local store

```bash
nix store sign --recursive --key-file ~/.config/nix/secret.key /run/current-system
```

Copy those paths to the cache

```bash
nix copy --to 's3://nix-cache?profile=nixbuilder&endpoint=s3.homelab.local' /run/current-system
```

### Add automatic object expiration policy

```bash
mc ilm rule add s3/nix-cache --expire-days "DAYS"
# e.g
# mc ilm rule add s3/nix-cache --expire-days "7"
```

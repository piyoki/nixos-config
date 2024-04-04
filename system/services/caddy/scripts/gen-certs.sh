#!/bin/sh

# Scripts to  generate certificates
# Generate the private key for the CA root certificate
openssl ecparam -genkey -name secp384r1 -out ecc-ca.key
# Generate the CA root certificate with the private key
# with the validity period of 10 years
openssl req -x509 -new -SHA512 -key ecc-ca.key -subj "/CN=Homelab Root CA 1" -days 3650 -out ecc-ca.crt
# Generate the private key for the server certificate
openssl ecparam -genkey -name secp384r1 -out ecc-server.key
# Generate the certificate signing request (CSR) for the server certificate
# using the private key and the configuration file ecc-csr.conf
openssl req -new -SHA512 key ecc-server.key -out ecc-server.csr -config ecc-csr.conf
# Sign the server certifite with the CA root certificate
openssl x509 -req -SHA512-in ecc-server.csr -CA ecc-ca.crt -CAkey ecc-ca.key \
  -CAcreateserial -out ecc-server.crt -days 3650 \
  -extensions v3_ext -extfile ecc-csr.conf
# Create a fullchain certifcate
cat ecc-ca.crt >ecc-fullchain.crt
cat ecc-server.crt >>ecc-fullchain.crt
# Verify results
openssl x509 -noout -text -in ecc-ca.crt
openssl x509 -noout -text -in ecc-server.crt# Generate the private key for the CA root certificate
openssl ecparam -genkey -name secp384r1 -out ecc-ca.key
# Generate the CA root certificate with the private key
# with the validity period of 10 years
openssl req -x509 -new -SHA512 -key ecc-ca.key -subj "/CN=Homelab Root CA 1" -days 3650 -out ecc-ca.crt
# Generate the private key for the server certificate
openssl ecparam -genkey -name secp384r1 -out ecc-server.key
# Generate the certificate signing request (CSR) for the server certificate
# using the private key and the configuration file ecc-csr.conf
openssl req -new -SHA512 -key ecc-server.key -out ecc-server.csr -config ecc-csr.conf
# Sign the server certificate with the CA root certificate
openssl x509 -req -SHA512 -in ecc-server.csr -CA ecc-ca.crt -CAkey ecc-ca.key \
  -CAcreateserial -out ecc-server.crt -days 3650 \
  -extensions v3_ext -extfile ecc-csr.conf
# Create a fullchain certifcate
cat ecc-ca.crt >ecc-fullchain.crt
cat ecc-server.crt >>ecc-fullchain.crt
# Verify results
openssl x509 -noout -text -in ecc-ca.crt
openssl x509 -noout -text -in ecc-server.crt

{ pkgs, lib, user, ... }:

with lib;
{
  # user patch
  users.users.${user} = {
    shell = mkForce pkgs.bash;
    extraGroups = mkForce [ "wheel" ];
    hashedPassword = "$7$CU..../....nnOYNef.N4rHN9q8TseVo1$cgf5w2iAkrNXxU1uwGI0HlFFGuwcU3l507b67v0Kp49";
  };
}

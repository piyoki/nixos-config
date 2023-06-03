{ pkgs, user, ... }:

let
  user = (import ./vars.nix).user;
in
{
  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwdl7F0NrGj+Z6LW6qg50SSC1cm7brKlujQdNt4+Bw6tnxL8uL9FNSBhgcscArCNRSZXw3RTMoyq2gH5SDClMtAstSicf8ReNXl4p5/aR94yE+baUFucHDFtJI1nKUdIy/2gPus9jtVY2AabtC4lhx+LN8tJ6AGHJNQvoQVcdQzGTuy2fk+HdtSm7HKOhAL0vh8tQXx/tHWz1y0sucqfK/ZNN5ATzwpy3/8hWQSwN1avv0mAcMm4Otx3RobIB4CtYcP9qFUM7d2nsa5vSskuB/eL9prz+zhtYnVxU/AdO5AVsSDIl71wBKHA/hC2lZscBaWCMQz61KvDnt+Gxr3Astpeytz9NQZvb1wvm678KrpvSeE6OXqsAYnuGUbgIZ194SShKYTHmpRZQT5presmpKXQQyORaNldx+yqpYTdRbsMjndSpPYauJJUygdnmTpRZ5MXFitckQ9LcHUW9R+HdWNV2yyQaSIjR7FZAjMwWy4ifeUIzcNUMkMKGEHI1q0Dk= kev@arch-desktop"
      ];
    };
    users.root = {
      shell = pkgs.bash;
    };
  };
}

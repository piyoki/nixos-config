{ pkgs, user, ... }:

{
  users.users.${user} = {
    shell = pkgs.fish;
    packages = with pkgs; [ fish ];
  };
}

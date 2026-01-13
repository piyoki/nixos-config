# Reference:
# https://github.com/joshurtree/hyprsession

{ inputs, system, ... }:

{
  environment.systemPackages = with inputs.hyprsession.packages.${system}; [ default ];
}

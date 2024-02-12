{ inputs, ... }:

{
  home.file.".local/ansible/inventory".source = inputs.home-estate + "/inventory";
  home.file.".local/ansible/playbooks".source = inputs.home-estate + "/playbooks";
}

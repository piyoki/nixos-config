_:

{
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      update_check = true;
      sync_address = "http://10.118.25.31:8888";
      sync_frequency = "10m";
    };
  };
}

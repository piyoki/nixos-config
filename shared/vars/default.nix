{
  user = "kev";
  defaultLocale = "en_US.UTF-8";
  # Ref: https://gist.github.com/alejzeis/ad5827eb14b5c22109ba652a1a267af5
  defaultTimeZone = "America/New_York";
  stateVersion = "25.05";

  # remote deploy
  targetPort = 22;
  targetUser = "root";
  tags = [ "server" ];
}

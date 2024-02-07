{ ... }:

{
  # cronie
  services.cron = {
    enable = true;
      systemCronJobs = [
        "*/10 * * * * gpgconf --reload scdaemon" # restart scdaemon every 10 minuts
        ];
  };
}

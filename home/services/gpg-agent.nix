{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    sshKeys = [
      "C02F30F9FD65E05531A321C8491E3EFE1C0C7383"
    ];
  };
}

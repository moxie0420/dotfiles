{...}: {
  services.mediawiki = {
    enable = true;
    name = "Moxies brew";

    extraConfig = ''
      $wgUpgradeKey = '5eb2fd4ba2cac452';
    '';

    passwordFile = ./tmppassword;

    httpd.virtualHost = {
      hostName = "nixowo";
      adminAddr = "astronomicalgamer5+wiki@gmail.com";
    };

    extensions = {
      # some extensions are included and can enabled by passing null
      VisualEditor = null;
    };
  };
}

{
  den,
  self,
  ...
}: {
  services.vaultwarden = {
    includes = [
      den.aspects.containers
    ];

    nixos = {config, ...}: {
      age.secrets.vaultwarden.file = "${self}/secrets/vaultwarden.age";

      virtualisation.oci-containers.containers = {
        "vaultwarden" = {
          environment = {
            DOMAIN = "https://vaultwarden.fell-opaleye.ts.net";
            SMTP_FROM = "noreply@moxiege.com";
            SMTP_HOST = "in-v3.mailjet.com";
            SMTP_PORT = "587";
            SMTP_SECURITY = "starttls";
            SSO_ALLOW_UNKNOWN_EMAIL_VERIFICATION = "false";
            SSO_AUTHORITY = "https://sso.moxiege.com/application/o/vaultwarden/";
            SSO_CLIENT_CACHE_EXPIRATION = "0";
            SSO_CLIENT_ID = "QtSSt5x7nlJ9y5QGsusUgn15blxs6WspWX25jAF4";
            SSO_ENABLED = "true";
            # Set to true to disable email and master password login and require SSO
            SSO_ONLY = "false";
            SSO_SCOPES = "openid profile email offline_access";
            # Match first SSO login to an existing account by email
            SSO_SIGNUPS_MATCH_EMAIL = "true";
          };
          environmentFiles = [config.age.secrets.vaultwarden.path];
          image = "vaultwarden/server:latest";
          ports = ["8812:80"];
          volumes = ["/opt/vaultwarden/_data:/data"];
        };
      };
    };
  };
}

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
          image = "vaultwarden/server:latest";
          environment = {
            DOMAIN = "https://vaultwarden.fell-opaleye.ts.net";

            SSO_ENABLED = "true";
            SSO_AUTHORITY = "https://sso.moxiege.com/application/o/vaultwarden/";
            SSO_CLIENT_ID = "QtSSt5x7nlJ9y5QGsusUgn15blxs6WspWX25jAF4";
            SSO_SCOPES = "openid profile email offline_access";
            SSO_ALLOW_UNKNOWN_EMAIL_VERIFICATION = "false";
            SSO_CLIENT_CACHE_EXPIRATION = "0";
            # Set to true to disable email and master password login and require SSO
            SSO_ONLY = "false";
            # Match first SSO login to an existing account by email
            SSO_SIGNUPS_MATCH_EMAIL = "true";

            SMTP_HOST = "in-v3.mailjet.com";
            SMTP_PORT = "587";
            SMTP_SECURITY = "starttls";
            SMTP_FROM = "noreply@moxiege.com";
          };

          environmentFiles = [config.age.secrets.vaultwarden.path];

          ports = ["8812:80"];
          volumes = ["/opt/vaultwarden/_data:/data"];
        };
      };
    };
  };
}

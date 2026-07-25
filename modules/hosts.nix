# Fleet topology: five hosts, policy-driven user access.
#
# Scope tree:
#   flake
#   +-- host:nixUwU
#   |   +-- user:madelyn
#   +-- host:nixOwO
#   |   +-- user:madelyn
#   |
#   +-- host:theHub
#   |   +-- user:madelyn
#   +-- host:web-0
#   |   +-- user:madelyn
#   +-- host:web-1
#   |   +-- user:madelyn
#   +-- host:web-2
#   |   +-- user:madelyn
#   +-- host:web-1
#       +-- user:madelyn
#
# defines all hosts + users + homes.
# then config their aspects in as many files you want
{lib, ...}: {
  # madelyn user at nixUwU host.
  den.hosts.x86_64-linux = {
    # My laptop
    nixOwO.users.madelyn = {};
    # My desktop
    nixUwU = {
      address = "192.168.50.109";
      addressV6 = "fe80::692:26ff:fed8:57a6/64";

      users.madelyn = {};
    };
    # Servers
    theHub = {
      address = "192.168.50.138";
      addressV6 = "";
      home-manager.enable = lib.mkForce false;
      users.madelyn = {};
    };
    # web-0 = {
    #   address = "192.168.50.10";
    #   addressV6 = "";
    #
    #   users.madelyn = { };
    #   home-manager.enable = false;
    # };
    # web-1 = {
    #   address = "192.168.50.11";
    #   addressV6 = "";
    #
    #   users.madelyn = { };
    #   home-manager.enable = false;
    # };
    # web-2 = {
    #   address = "192.168.50.12";
    #   addressV6 = "";
    #
    #   users.madelyn = { };
    #   home-manager.enable = false;
    # };
    # web-3 = {
    #   address = "192.168.50.13";
    #   addressV6 = "";
    #
    #   users.madelyn = { };
    #   home-manager.enable = false;
    # };
  };
}

# defines all hosts + users + homes.
# then config their aspects in as many files you want
{
  # madeline user at nixUwU host.
  den.hosts.x86_64-linux = {
    nixUwU.users.madeline = {};
    nixOwO.users.madeline = {};
  };

  # define an standalone home-manager for moxie
  den.homes.x86_64-linux.madeline = {};

  # be sure to add nix-darwin input for this:
  # den.hosts.aarch64-darwin.apple.users.alice = { };

  # other hosts can also have user moxie.
  # den.hosts.x86_64-linux.south = {
  #   wsl = { }; # add nixos-wsl input for this.
  #   users.moxie = { };
  #   users.orca = { };
  # };
}

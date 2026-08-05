{ moduleWithSystem, inputs, ... }: {

  flake.nixosModules.git = moduleWithSystem (
    { self', ... }: {
      programs.git = {
        enable = true;
        package = self'.packages.git;
      };
    }
  );

  perSystem = { pkgs, ... }: {
    packages.git = inputs.wrappers.wrappers.git.wrap {
      inherit pkgs;
      settings = {
        user = {
          email = "me@nospawnn.com";
          name = "Red";
        };
        credential.helper = "store";
      };
    };
  };
}

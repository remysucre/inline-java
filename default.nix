let
  pkgs = import ./nix/nixpkgs.nix;

  hsPkgs =
    pkgs.haskell // {
      packages = pkgs.haskell.packages // {
        ghc802 = pkgs.haskell.packages.ghc802.override {
          overrides = self: super: {
            jni =
              self.callPackage ./jni/jni.nix {
                jdk = pkgs.openjdk8;
              };
            jvm =
              self.callPackage ./jvm/jvm.nix {};
          };
        };
      };
    };
in
  hsPkgs.packages.ghc802.callPackage ./nix/inline-java.nix {}
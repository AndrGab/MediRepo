{
  description = ''
    Gerenciador de boletos
  '';

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    rec {
      devShells."${system}".default = with pkgs; mkShell {
        name = "billet_manager";
        buildInputs = [
          gnumake
          gcc
          readline
          openssl
          zlib
          libxml2
          curl
          libiconv
          elixir
          beamPackages.rebar3
          glibcLocales
          postgresql
        ] ++ lib.optional stdenv.isLinux [
          inotify-tools
          # observer gtk engine
          gtk-engine-murrine
        ]
        ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
          CoreFoundation
          CoreServices
        ]);

        # define shell startup command
        shellHook = ''
          # create local tmp folders
          mkdir -p .nix-mix
          mkdir -p .nix-hex

          mix local.hex --force --if-missing
          mix local.rebar --force --if-missing

          # to not conflict with your host elixir
          # version and supress warnings about standard
          # libraries
          export ERL_LIBS="$HEX_HOME/lib/erlang/lib"
        '';
      };
    };
}

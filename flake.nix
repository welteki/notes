{
  description = "Personal wiki and notes";
  
  inputs.utils.url   = "github:numtide/flake-utils";
  inputs.neuron.url = "github:srid/neuron";
  inputs.emanote.url = "github:srid/emanote";

  outputs = { self, nixpkgs, utils, neuron, emanote }: {
    overlay = final: prev: {
      emanote = emanote.defaultPackage.${final.system};
      neuron = neuron.defaultPackage.${prev.system};

      notes = prev.stdenv.mkDerivation {
        pname = "welteki-notes";
        version = "0.0.1";
        src = ./.;
        buildInputs = [ final.neuron ];
        buildPhase = ''
          neuron gen --pretty-urls
        '';
        installPhase = ''
          cp -r .neuron/output/ $out
        '';
      };
    };

  } // utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlay ];
    };
  in
  {
    defaultPackage = pkgs.notes;

    devShell = pkgs.mkShell {
      buildInputs = [
        pkgs.emanote
        pkgs.neuron
      ];
    };
  });
}

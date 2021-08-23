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
        version = "0.2.0";
        src = ./.;
        buildInputs = [ final.emanote ];
        buildPhase = ''
          mkdir -p .emanote/output
          emanote gen .emanote/output
        '';
        installPhase = ''
          cp -r .emanote/output/ $out
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

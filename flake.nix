{
  description = "Personal wiki and notes";
  
  inputs.utils.url   = "github:numtide/flake-utils";
  inputs.neuron.url = "github:srid/neuron";

  outputs = { self, nixpkgs, utils, neuron }: {
    overlay = final: prev: {
      notes = prev.stdenv.mkDerivation {
        pname = "welteki-notes";
        version = "0.0.1";
        src = ./.;
        buildInputs = [ prev.neuron ];
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
    neuron-overlay = final: prev: {
      neuron = neuron.defaultPackage.${system};
    };

    pkgs = import nixpkgs {
      inherit system;
      # important: neuron-overlay should be applied first
      overlays = [ neuron-overlay self.overlay ];
    };
  in
  {
    defaultPackage = pkgs.notes;

    devShell = pkgs.mkShell {
      buildInputs = [
        pkgs.neuron
      ];
    };
  });
}

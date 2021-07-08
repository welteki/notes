{
  description = "Personal wiki and notes";
  
  inputs.neuron.url = "github:srid/neuron";

  outputs = { self, nixpkgs, neuron }: 
    let
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      devShell = forAllSystems (system:
        let
          inherit (nixpkgs.legacyPackages.${system}) mkShell;
        in
        mkShell {
          buildInputs = [
            neuron.defaultPackage.${system}
          ];
        });
    };
}

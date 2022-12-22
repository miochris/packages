{ pkgs ? import <nixpkgs> { } }: {
  jl2 = pkgs.buildGoModule rec {
    pname = "jl2";
    version = "0.1.0";
    src = pkgs.fetchFromGitHub {
      owner = "mightyguava";
      repo = "jl";
      rev = "v${version}";
      sha256 = "sha256-4EL8zceOs54LCjsLw3Sa7AM72kqcN3zoSgV0IIe8DWw=";
    };
    vendorSha256 = "sha256-fGp87Fo/gwjjqW7OBBYz5KYlguv1UioqKcKyAE9XB2g=";
  };
}

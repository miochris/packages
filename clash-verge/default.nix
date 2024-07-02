{ pkgs ? import <nixpkgs> { } }: {
  jl = pkgs.buildGoModule rec {
    pname = "clash-verge";
    version = "1.3.2";
    src = pkgs.fetchFromGitHub {
      owner = "zzzgydi";
      repo = "clash-verge";
      rev = "v${version}";
      sha256 = "sha256-mOTZFmLMKW3tRNFNgJPH+pxhLPYk5WuPCwnUJYIvjco=";
    };
    vendorSha256 = "sha256-mRyMZq+MhPLplrZCR/AzWb48VhVEYBKftwlDZFIU7ug=";
  };
}

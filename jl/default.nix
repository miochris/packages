{ pkgs ? import <nixpkgs> { } }: {
  jl = pkgs.buildGoModule rec {
    pname = "jl";
    version = "1.4.0";
    src = pkgs.fetchFromGitHub {
      owner = "koenbollen";
      repo = "jl";
      rev = "v${version}";
      sha256 = "sha256-cEFbCvOkYNbYxQC6q4Jrl1jR48gXskBts9OTUEgnXoY=";
    };
    vendorSha256 = "sha256-mRyMZq+MhPLplrZCR/AzWb48VhVEYBKftwlDZFIU7ug=";
  };
}

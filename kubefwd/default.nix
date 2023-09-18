{ pkgs ? import <nixpkgs> { } }: {
  jl2 = pkgs.buildGoModule rec {
    pname = "kubefwd";
    version = "1.22.3";
    src = pkgs.fetchFromGitHub {
      owner = "txn2";
      repo = "kubefwd";
      rev = "v${version}";
      sha256 = "sha256-OpPlS7TTwtgOoEoAIc0XxM0Fmw5I8jKWbUrH6NVDgl4=";
    };
    vendorSha256 = "sha256-oeRShx5lYwJ9xFPg5Ch0AzdQXwX/5OA3EyuumgH9gXU=";
  };
}

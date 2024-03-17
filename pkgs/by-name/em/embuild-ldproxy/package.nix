{ lib
, fetchFromGitHub
, rustPlatform
}:
rustPlatform.buildRustPackage rec {
  pname = "embuild-ldproxy";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "esp-rs";
    repo = "embuild";
    rev = "ldproxy-v${version}";
    hash = "sha256-68Gxo96cLp2ArGAfREESjmNX/aDzt+kWneC5gkfadng=";
  };

  cargoHash = "sha256-JaMgBvA4uYLlfCu9M7sRl87h7gZIo0pG/gsVyg9dc4M=";

  buildAndTestSubdir = "ldproxy";

  meta = with lib; {
    description = "A simple tool to forward linker arguments to the actual linker";
    homepage = "https://github.com/esp-rs/embuild/tree/master/ldproxy";
    license = with lib.licenses; [ asl20 mit ];
    maintainers = with maintainers; [ dannixon ];
  };
}

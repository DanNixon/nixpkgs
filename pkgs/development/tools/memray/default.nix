{ lib
, fetchFromGitHub
, libunwind
, lz4
, pkg-config
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "memray";
  version = "1.8.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "bloomberg";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-jn14bWluN8kApIVpXX5TeoFA1FDTlkOaz6QfFSz0ojU=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libunwind
    lz4
  ] ++ (with python3.pkgs; [
    cython
  ]);

  propagatedBuildInputs = with python3.pkgs; [
    jinja2
    rich
  ];

  nativeCheckInputs = with python3.pkgs; [
    ipython
    pytestCheckHook
  ] ++ lib.optionals (pythonOlder "3.11") [
    greenlet
  ];

  pythonImportsCheck = [
    "memray"
  ];

  pytestFlagsArray = [
    "tests"
  ];

  disabledTests = [
    # Import issue
    "test_header_allocator"
    "test_hybrid_stack_of_allocations_inside_ceval"
  ];

  disabledTestPaths = [
    # Very time-consuming and some tests fails (performance-related?)
    "tests/integration/test_main.py"
  ];

  meta = with lib; {
    description = "Memory profiler for Python";
    homepage = "https://bloomberg.github.io/memray/";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
    platforms = platforms.linux;
    changelog = "https://github.com/bloomberg/memray/releases/tag/v${version}";
  };
}

# generated using pypi2nix tool (version: 2.0.1)
# See more at: https://github.com/nix-community/pypi2nix
#
# COMMAND:
#   pypi2nix -e instawow
#

{ pkgs ? import <nixpkgs> {},
  overrides ? ({ pkgs, python }: self: super: {})
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python3;
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = args: pythonPackages.buildPythonPackage (args // {
        nativeBuildInputs = (args.nativeBuildInputs or []) ++ args.buildInputs;
      });
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "aiohttp" = python.mkDerivation {
      name = "aiohttp-3.6.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/00/94/f9fa18e8d7124d7850a5715a0b9c0584f7b9375d331d35e157cee50f27cc/aiohttp-3.6.2.tar.gz";
        sha256 = "259ab809ff0727d0e834ac5e8a283dc5e3e0ecc30c4d80b3cd17a4139ce1f326";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."async-timeout"
        self."attrs"
        self."chardet"
        self."multidict"
        self."yarl"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/aiohttp";
        license = licenses.asl20;
        description = "Async http client/server framework (asyncio)";
      };
    };

    "alembic" = python.mkDerivation {
      name = "alembic-1.2.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6f/42/48447bf41287bc577e4f340e7c28578e322567f5622a915bdfa01c83dc76/alembic-1.2.1.tar.gz";
        sha256 = "9f907d7e8b286a1cfb22db9084f9ce4fde7ad7956bb496dc7c952e10ac90e36a";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."mako"
        self."python-dateutil"
        self."python-editor"
        self."sqlalchemy"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://alembic.sqlalchemy.org";
        license = licenses.mit;
        description = "A database migration tool for SQLAlchemy.";
      };
    };

    "async-timeout" = python.mkDerivation {
      name = "async-timeout-3.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a1/78/aae1545aba6e87e23ecab8d212b58bb70e72164b67eb090b81bb17ad38e3/async-timeout-3.0.1.tar.gz";
        sha256 = "0c3c816a028d47f659d6ff5c745cb2acf1f966da1fe5c19c77a70282b25f4c5f";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/async_timeout/";
        license = licenses.asl20;
        description = "Timeout context manager for asyncio programs";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/bd/69/2833f182ea95ea1f17e9a7559b8b92ebfdf4f68b5c58b15bc10f47bc2e01/attrs-19.2.0.tar.gz";
        sha256 = "f913492e1663d3c36f502e5e9ba6cd13cf19d7fab50aa13239e420fef95e1396";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "click" = python.mkDerivation {
      name = "click-7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f8/5c/f60e9d8a1e77005f664b76ff8aeaee5bc05d0a91798afd7f53fc998dbc47/Click-7.0.tar.gz";
        sha256 = "5b94b49521f6456670fdb30cd82a4eca9412788a93fa6dd6df72c94d5a8ff2d7";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/click/";
        license = licenses.bsdOriginal;
        description = "Composable command line interface toolkit";
      };
    };

    "fuzzywuzzy" = python.mkDerivation {
      name = "fuzzywuzzy-0.17.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/81/54/586e9f34401dc7f5248589765bb67d49b837e2f309f25a33e82e896cba0a/fuzzywuzzy-0.17.0.tar.gz";
        sha256 = "6f49de47db00e1c71d40ad16da42284ac357936fa9b66bea1df63fed07122d62";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/seatgeek/fuzzywuzzy";
        license = "GPL";
        description = "Fuzzy string matching in python";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz";
        sha256 = "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "instawow" = python.mkDerivation {
      name = "instawow-1.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/58/e5/ffeec394a2598d2c888dbaea8f2138bd967298b45935a7f5a0edd2bb3f28/instawow-1.6.0.tar.gz";
        sha256 = "7c883035502fd5419f04a2fd25c5e8460038038debe0eab2dd685cac2089c766";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."aiohttp"
        self."alembic"
        self."async-timeout"
        self."attrs"
        self."chardet"
        self."click"
        self."fuzzywuzzy"
        self."idna"
        self."jinja2"
        self."loguru"
        self."lupa"
        self."mako"
        self."markupsafe"
        self."multidict"
        self."prompt-toolkit"
        self."pydantic"
        self."python-dateutil"
        self."python-editor"
        self."questionary"
        self."six"
        self."sqlalchemy"
        self."texttable"
        self."typing-extensions"
        self."wcwidth"
        self."yarl"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/layday/instawow";
        license = "GPL-3.0-or-later";
        description = "A CLI for managing World of Warcraft add-ons.";
      };
    };

    "jinja2" = python.mkDerivation {
      name = "jinja2-2.10.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7b/db/1d037ccd626d05a7a47a1b81ea73775614af83c2b3e53d86a0bb41d8d799/Jinja2-2.10.3.tar.gz";
        sha256 = "9fe95f19286cfefaa917656583d020be14e7859c6b0252588391e47db34527de";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."markupsafe"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/jinja/";
        license = licenses.bsdOriginal;
        description = "A very fast and expressive template engine.";
      };
    };

    "loguru" = python.mkDerivation {
      name = "loguru-0.3.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5c/de/42db5a4bf0f02786a54ed34b676536499c74bc09540c60d70022652d1c5b/loguru-0.3.2.tar.gz";
        sha256 = "e3138bfdee5f57481a2a6e078714be20f8c71ab1ff3f07f8fb1cfa25191fed2a";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Delgan/loguru";
        license = licenses.mit;
        description = "Python logging made (stupidly) simple";
      };
    };

    "lupa" = python.mkDerivation {
      name = "lupa-1.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7f/73/b26eb44603dc47e32b9a308e15cdf613aa3eeba073004d11572182e5df92/lupa-1.8.tar.gz";
        sha256 = "f55781c9ab8fab77aa438481067a72da0b04849e2790a4e80d3c9bc77d7f8e53";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/scoder/lupa";
        license = licenses.mit;
        description = "Python wrapper around Lua and LuaJIT";
      };
    };

    "mako" = python.mkDerivation {
      name = "mako-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b0/3c/8dcd6883d009f7cae0f3157fb53e9afb05a0d3d33b3db1268ec2e6f4a56b/Mako-1.1.0.tar.gz";
        sha256 = "a36919599a9b7dc5d86a7a8988f23a9a3a3d083070023bab23d64f7f1d1e0a4b";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."markupsafe"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.makotemplates.org/";
        license = licenses.mit;
        description = "A super-fast templating language that borrows the  best ideas from the existing templating languages.";
      };
    };

    "markupsafe" = python.mkDerivation {
      name = "markupsafe-1.1.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz";
        sha256 = "29872e92839765e546828bb7754a68c418d927cd064fd4708fab9fe9c8bb116b";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/markupsafe/";
        license = licenses.bsdOriginal;
        description = "Safely add untrusted strings to HTML/XML markup.";
      };
    };

    "multidict" = python.mkDerivation {
      name = "multidict-4.5.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7f/8f/b3c8c5b062309e854ce5b726fc101195fbaa881d306ffa5c2ba19efa3af2/multidict-4.5.2.tar.gz";
        sha256 = "024b8129695a952ebd93373e45b5d341dbb87c17ce49637b34000093f243dd4f";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/multidict";
        license = licenses.asl20;
        description = "multidict implementation";
      };
    };

    "prompt-toolkit" = python.mkDerivation {
      name = "prompt-toolkit-2.0.10";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0c/37/7ad3bf3c6dbe96facf9927ddf066fdafa0f86766237cff32c3c7355d3b7c/prompt_toolkit-2.0.10.tar.gz";
        sha256 = "f15af68f66e664eaa559d4ac8a928111eebd5feda0c11738b5998045224829db";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
        self."wcwidth"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jonathanslenders/python-prompt-toolkit";
        license = licenses.bsdOriginal;
        description = "Library for building powerful interactive command lines in Python";
      };
    };

    "pydantic" = python.mkDerivation {
      name = "pydantic-0.32.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/56/dd/295bd423d42e01604b9656a0dfcd3dc6d49731595fe9bcdaf6e2df797ef4/pydantic-0.32.2.tar.gz";
        sha256 = "6a9335c968e13295430a208487e74d69fef40168b72dea8d975765d14e2da660";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/samuelcolvin/pydantic";
        license = licenses.mit;
        description = "Data validation and settings management using python 3.6 type hinting";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/99/5b2e99737edeb28c71bcbec5b5dda19d0d9ef3ca3e92e3e925e7c0bb364c/python-dateutil-2.8.0.tar.gz";
        sha256 = "c89805f6f4d64db21ed966fda138f8a5ed7a4fdbc1a8ee329ce1b74e3c74da9e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };

    "python-editor" = python.mkDerivation {
      name = "python-editor-1.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0a/85/78f4a216d28343a67b7397c99825cff336330893f00601443f7c7b2f2234/python-editor-1.0.4.tar.gz";
        sha256 = "51fda6bcc5ddbbb7063b2af7509e43bd84bfc32a4ff71349ec7847713882327b";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/fmoo/python-editor";
        license = licenses.asl20;
        description = "Programmatically open an editor, capture the result.";
      };
    };

    "questionary" = python.mkDerivation {
      name = "questionary-1.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/05/c7/21f443dc9730c7f9d7c9556e34ea5bedcb28b32a75a765336005eda10763/questionary-1.3.0.tar.gz";
        sha256 = "867c6ef08a139eacc509502292dcc764cf95abbcfcb0ffdea29df5782434cb64";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."prompt-toolkit"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tmbo/questionary";
        license = licenses.mit;
        description = "";
      };
    };

    "setuptools" = python.mkDerivation {
      name = "setuptools-42.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f7/b6/5b98441b6749ea1db1e41e5e6e7a93cbdd7ffd45e11fe1b22d45884bc777/setuptools-42.0.2.zip";
        sha256 = "c5b372090d7c8709ce79a6a66872a91e518f7d65af97fca78135e1cb10d4b940";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools";
        license = licenses.mit;
        description = "Easily download, build, install, upgrade, and uninstall Python packages";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-3.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/83/44/53cad68ce686585d12222e6769682c4bdb9686808d2739671f9175e2938b/setuptools_scm-3.3.3.tar.gz";
        sha256 = "bd25e1fb5e4d603dcf490f1fde40fb4c595b357795674c3e5cb7f6217ab39ea5";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.12.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz";
        sha256 = "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "sqlalchemy" = python.mkDerivation {
      name = "sqlalchemy-1.3.10";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/14/0e/487f7fc1e432cec50d2678f94e4133f2b9e9356e35bacc30d73e8cb831fc/SQLAlchemy-1.3.10.tar.gz";
        sha256 = "0f0768b5db594517e1f5e1572c73d14cf295140756431270d89496dc13d5e46c";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.sqlalchemy.org";
        license = licenses.mit;
        description = "Database Abstraction Library";
      };
    };

    "texttable" = python.mkDerivation {
      name = "texttable-1.6.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/82/a8/60df592e3a100a1f83928795aca210414d72cebdc6e4e0c95a6d8ac632fe/texttable-1.6.2.tar.gz";
        sha256 = "eff3703781fbc7750125f50e10f001195174f13825a92a45e9403037d539b4f4";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/foutaise/texttable/";
        license = licenses.mit;
        description = "module for creating simple ASCII tables";
      };
    };

    "typing-extensions" = python.mkDerivation {
      name = "typing-extensions-3.7.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/59/b6/21774b993eec6e797fbc49e53830df823b69a3cb62f94d36dfb497a0b65a/typing_extensions-3.7.4.tar.gz";
        sha256 = "2ed632b30bb54fc3941c382decfd0ee4148f5c591651c9272473fea2c6397d95";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/python/typing/blob/master/typing_extensions/README.rst";
        license = licenses.psfl;
        description = "Backported and Experimental Type Hints for Python 3.5+";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz";
        sha256 = "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description = "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "wheel" = python.mkDerivation {
      name = "wheel-0.33.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/59/b0/11710a598e1e148fb7cbf9220fd2a0b82c98e94efbdecb299cb25e7f0b39/wheel-0.33.6.tar.gz";
        sha256 = "10c9da68765315ed98850f8e048347c3eb06dd81822dc2ab1d4fde9dc9702646";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/wheel";
        license = licenses.mit;
        description = "A built-package format for Python.";
      };
    };

    "yarl" = python.mkDerivation {
      name = "yarl-1.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fb/84/6d82f6be218c50b547aa29d0315e430cf8a23c52064c92d0a8377d7b7357/yarl-1.3.0.tar.gz";
        sha256 = "024ecdc12bc02b321bc66b41327f930d1c2c543fa9a561b39861da9388ba7aa9";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."idna"
        self."multidict"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/yarl/";
        license = licenses.asl20;
        description = "Yet another URL library";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (let src = pkgs.fetchFromGitHub { owner = "nix-community"; repo = "pypi2nix-overrides"; rev = "db87933d87d9b3943cf636a49f16b76c9ea66db7"; sha256 = "1phiqh72dyg7qhkv15kdg4gjkx8rkywvs41j7liz5faj66ijlpv6"; } ; in import "${src}/overrides.nix" { inherit pkgs python; })
  ];
  paramOverrides = [
    (overrides { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [localOverrides] else [] ) ++ commonOverrides ++ paramOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )
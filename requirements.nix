# generated using pypi2nix tool (version: 2.0.4)
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
      format = "setuptools";
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
      name = "alembic-1.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/60/1e/cabc75a189de0fbb2841d0975243e59bde8b7822bacbb95008ac6fe9ad47/alembic-1.4.2.tar.gz";
        sha256 = "035ab00497217628bf5d0be82d664d8713ab13d37b630084da8e1f98facf4dbf";
};
      doCheck = commonDoCheck;
      format = "pyproject";
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
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/async_timeout/";
        license = licenses.asl20;
        description = "Timeout context manager for asyncio programs";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/98/c3/2c227e66b5e896e15ccdae2e00bbc69aa46e9a8ce8869cc5fa96310bf612/attrs-19.3.0.tar.gz";
        sha256 = "f7b7ce16570fe9965acd6d30101a28f62fb4a7f9e926b3bbc9b61f8b04247e72";
};
      doCheck = commonDoCheck;
      format = "pyproject";
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
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "click" = python.mkDerivation {
      name = "click-7.1.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4e/ab/5d6bc3b697154018ef196f5b17d958fac3854e2efbc39ea07a284d4a6a9b/click-7.1.1.tar.gz";
        sha256 = "8a18b4ea89d8820c5d0c7da8a64b2c324b4dabb695804dbfea19b9be9d88c0cc";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/click/";
        license = licenses.bsdOriginal;
        description = "Composable command line interface toolkit";
      };
    };

    "fuzzywuzzy" = python.mkDerivation {
      name = "fuzzywuzzy-0.18.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/11/4b/0a002eea91be6048a2b5d53c5f1b4dafd57ba2e36eea961d05086d7c28ce/fuzzywuzzy-0.18.0.tar.gz";
        sha256 = "45016e92264780e58972dca1b3d939ac864b78437422beecebb3095f8efd00e8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/seatgeek/fuzzywuzzy";
        license = licenses.gpl2;
        description = "Fuzzy string matching in python";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cb/19/57503b5de719ee45e83472f339f617b0c01ad75cba44aba1e4c97c2b0abd/idna-2.9.tar.gz";
        sha256 = "7588d1c14ae4c77d74036e8c22ff447b26d0fde8f007354fd48a7814db15b7cb";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "importlib-metadata" = python.mkDerivation {
      name = "importlib-metadata-1.5.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/d7/cd/3b1dffa46b19dac269d586b9d45090588a8bd7a5741602a369d45e1bdf65/importlib_metadata-1.5.2.tar.gz";
        sha256 = "dfc83688553a91a786c6c91eeb5f3b1d31f24d71877bbd94ecbf5484e57690a2";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."zipp"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://importlib-metadata.readthedocs.io/";
        license = licenses.asl20;
        description = "Read metadata from Python packages";
      };
    };

    "instawow" = python.mkDerivation {
      name = "instawow-1.7.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a6/0d/1fd7b14fdec081810207c7d3e6a9cb059cb0da3e930dffbcf17339ad66af/instawow-1.7.2.tar.gz";
        sha256 = "d4c1ab362550bb66aef2256b71518a36777b48d11ebe7b49f12291ca69630f91";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."aiohttp"
        self."alembic"
        self."click"
        self."fuzzywuzzy"
        self."importlib-metadata"
        self."jinja2"
        self."loguru"
        self."lupa"
        self."prompt-toolkit"
        self."pydantic"
        self."questionary"
        self."sqlalchemy"
        self."typing-extensions"
        self."yarl"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/layday/instawow";
        license = "GPL-3.0-or-later";
        description = "CLI for managing World of Warcraft add-ons";
      };
    };

    "jinja2" = python.mkDerivation {
      name = "jinja2-2.11.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/d8/03/e491f423379ea14bb3a02a5238507f7d446de639b623187bccc111fbecdf/Jinja2-2.11.1.tar.gz";
        sha256 = "93187ffbc7808079673ef52771baa950426fd664d3aad1d0fa3e95644360e250";
};
      doCheck = commonDoCheck;
      format = "setuptools";
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
      name = "loguru-0.4.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b8/b7/ec749f8f95454d6043900f99d8e6ec48be89f62d861e909c3eb0407c54a7/loguru-0.4.1.tar.gz";
        sha256 = "a6101fd435ac89ba5205a105a26a6ede9e4ddbb4408a6e167852efca47806d11";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Delgan/loguru";
        license = licenses.mit;
        description = "Python logging made (stupidly) simple";
      };
    };

    "lupa" = python.mkDerivation {
      name = "lupa-1.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e4/44/85d9a962dd135c74d82edec606691f1f4db664f11fe8393eef4146bb98d7/lupa-1.9.tar.gz";
        sha256 = "a3e11d806ca02cf72e490ec1974f8b96a14a1091895c9dccebe0b8d52dd82e8e";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/scoder/lupa";
        license = licenses.mit;
        description = "Python wrapper around Lua and LuaJIT";
      };
    };

    "mako" = python.mkDerivation {
      name = "mako-1.1.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/42/64/fc7c506d14d8b6ed363e7798ffec2dfe4ba21e14dda4cfab99f4430cba3a/Mako-1.1.2.tar.gz";
        sha256 = "3139c5d64aa5d175dbafb95027057128b5fbd05a40c53999f3905ceb53366d9d";
};
      doCheck = commonDoCheck;
      format = "setuptools";
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
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/markupsafe/";
        license = licenses.bsdOriginal;
        description = "Safely add untrusted strings to HTML/XML markup.";
      };
    };

    "multidict" = python.mkDerivation {
      name = "multidict-4.7.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/61/b4/475114b3f1671da634f89239e61038f8742d9ac13aa34b32a05bf8022d22/multidict-4.7.5.tar.gz";
        sha256 = "aee283c49601fa4c13adc64c09c978838a7e812f85377ae130a24d7198c0331e";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."pip"
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/aio-libs/multidict";
        license = licenses.asl20;
        description = "multidict implementation";
      };
    };

    "pip" = python.mkDerivation {
      name = "pip-20.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8e/76/66066b7bc71817238924c7e4b448abdb17eb0c92d645769c223f9ace478f/pip-20.0.2.tar.gz";
        sha256 = "7db0c8ea4c7ea51c8049640e8e6e7fde949de672bfa4949920675563a5a6967f";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pip.pypa.io/";
        license = licenses.mit;
        description = "The PyPA recommended tool for installing Python packages.";
      };
    };

    "prompt-toolkit" = python.mkDerivation {
      name = "prompt-toolkit-2.0.10";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0c/37/7ad3bf3c6dbe96facf9927ddf066fdafa0f86766237cff32c3c7355d3b7c/prompt_toolkit-2.0.10.tar.gz";
        sha256 = "f15af68f66e664eaa559d4ac8a928111eebd5feda0c11738b5998045224829db";
};
      doCheck = commonDoCheck;
      format = "setuptools";
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
      name = "pydantic-1.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0d/0f/5dd883399fca772c441f4fd8db85320fa7a912fa2f917f0cee1f681f9a93/pydantic-1.4.tar.gz";
        sha256 = "f17ec336e64d4583311249fb179528e9a2c27c8a2eaf590ec6ec2c6dece7cb3f";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/samuelcolvin/pydantic";
        license = licenses.mit;
        description = "Data validation and settings management using python 3.6 type hinting";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.8.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz";
        sha256 = "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c";
};
      doCheck = commonDoCheck;
      format = "pyproject";
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
      format = "setuptools";
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
      format = "setuptools";
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
      name = "setuptools-46.1.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b5/96/af1686ea8c1e503f4a81223d4a3410e7587fd52df03083de24161d0df7d4/setuptools-46.1.3.zip";
        sha256 = "795e0475ba6cd7fa082b1ee6e90d552209995627a2a227a47c6ea93282f4bfb1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools";
        license = licenses.mit;
        description = "Easily download, build, install, upgrade, and uninstall Python packages";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-3.5.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b2/f7/60a645aae001a2e06cf4b8db2fba9d9f36b8fd378f10647e3e218b61b74b/setuptools_scm-3.5.0.tar.gz";
        sha256 = "5bdf21a05792903cafe7ae0c9501182ab52497614fa6b1750d9dbae7b60c1a87";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.14.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz";
        sha256 = "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "sqlalchemy" = python.mkDerivation {
      name = "sqlalchemy-1.3.15";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8c/30/4134e726dd5ed13728ff814fa91fc01c447ad8700504653fe99d91fdd34b/SQLAlchemy-1.3.15.tar.gz";
        sha256 = "c4cca4aed606297afbe90d4306b49ad3a4cd36feb3f87e4bfd655c57fd9ef445";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.sqlalchemy.org";
        license = licenses.mit;
        description = "Database Abstraction Library";
      };
    };

    "toml" = python.mkDerivation {
      name = "toml-0.10.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b9/19/5cbd78eac8b1783671c40e34bb0fa83133a06d340a38b55c645076d40094/toml-0.10.0.tar.gz";
        sha256 = "229f81c57791a41d65e399fc06bf0848bab550a9dfd5ed66df18ce5f05e73d5c";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/uiri/toml";
        license = licenses.mit;
        description = "Python Library for Tom's Obvious, Minimal Language";
      };
    };

    "typing-extensions" = python.mkDerivation {
      name = "typing-extensions-3.7.4.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e7/dd/f1713bc6638cc3a6a23735eff6ee09393b44b96176d3296693ada272a80b/typing_extensions-3.7.4.1.tar.gz";
        sha256 = "091ecc894d5e908ac75209f10d5b4f118fbdb2eb1ede6a63544054bb1edb41f2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/python/typing/blob/master/typing_extensions/README.rst";
        license = licenses.psfl;
        description = "Backported and Experimental Type Hints for Python 3.5+";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/25/9d/0acbed6e4a4be4fc99148f275488580968f44ddb5e69b8ceb53fc9df55a0/wcwidth-0.1.9.tar.gz";
        sha256 = "ee73862862a156bf77ff92b09034fc4825dd3af9cf81bc5b360668d425f3c5f1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description = "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "wheel" = python.mkDerivation {
      name = "wheel-0.34.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/75/28/521c6dc7fef23a68368efefdcd682f5b3d1d58c2b90b06dc1d0b805b51ae/wheel-0.34.2.tar.gz";
        sha256 = "8788e9155fe14f54164c1b9eb0a319d98ef02c160725587ad60f14ddc57b6f96";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/wheel";
        license = licenses.mit;
        description = "A built-package format for Python";
      };
    };

    "yarl" = python.mkDerivation {
      name = "yarl-1.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/d6/67/6e2507586eb1cfa6d55540845b0cd05b4b77c414f6bca8b00b45483b976e/yarl-1.4.2.tar.gz";
        sha256 = "58cd9c469eced558cd81aa3f484b2924e8897049e06889e8ff2510435b7ef74b";
};
      doCheck = commonDoCheck;
      format = "setuptools";
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

    "zipp" = python.mkDerivation {
      name = "zipp-3.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ce/8c/2c5f7dc1b418f659d36c04dec9446612fc7b45c8095cc7369dd772513055/zipp-3.1.0.tar.gz";
        sha256 = "c599e4d75c98f6798c509911d08a22e6c021d074469042177c8c86fb92eefd96";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."setuptools-scm"
        self."wheel"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jaraco/zipp";
        license = licenses.mit;
        description = "Backport of pathlib-compatible object wrapper for zip files";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (let src = pkgs.fetchFromGitHub { owner = "nix-community"; repo = "pypi2nix-overrides"; rev = "100c15ec7dfe7d241402ecfb1e796328d0eaf1ec"; sha256 = "0akfkvdakcdxc1lrxznh1rz2811x4pafnsq3jnyr5pn3m30pc7db"; } ; in import "${src}/overrides.nix" { inherit pkgs python; })
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
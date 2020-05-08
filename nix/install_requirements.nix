# generated using pypi2nix tool (version: 2.0.4)
# See more at: https://github.com/nix-community/pypi2nix
#
# COMMAND:
#   pypi2nix -V python38 -r ../python_requirements/install_requirements.txt --basename install_requirements -E postgresql_12 -E libffi -E openssl.dev -s setuptools-scm
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
    python = pkgs.python38;
  };

  commonBuildInputs = with pkgs; [ postgresql_12 libffi openssl.dev ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python38-interpreter";
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

    "babel" = python.mkDerivation {
      name = "babel-2.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/34/18/8706cfa5b2c73f5a549fdc0ef2e24db71812a2685959cff31cbdfc010136/Babel-2.8.0.tar.gz";
        sha256 = "1aac2ae2d0d8ea368fa90906567f5c08463d98ade155c0c4bfedd6a0f7160e38";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytz"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://babel.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "Internationalization utilities";
      };
    };

    "boltons" = python.mkDerivation {
      name = "boltons-20.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/42/38/ce1ab39b04e1c9946a9dc1076f01d138fb0bbbda1aae48709193b30629e1/boltons-20.1.0.tar.gz";
        sha256 = "6e890b173c5f2dcb4ec62320b3799342ecb1a6a0b2253014455387665d62c213";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mahmoud/boltons";
        license = licenses.bsdOriginal;
        description = "When they're not builtins, they're boltons.";
      };
    };

    "case-conversion" = python.mkDerivation {
      name = "case-conversion-2.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cb/8c/14731e4d4f6fd9876575abc7df9861bcb0a21d764f7ac622ab5485c45afe/case_conversion-2.1.0.tar.gz";
        sha256 = "4114aaed4213f2235f1648502fd1793e5fdfa3fa86f85979fd2d0dce1584e197";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."regex"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/AlejandroFrias/case-conversion";
        license = licenses.mit;
        description = "Convert between different types of cases (unicode supported)";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2020.4.5.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b8/e2/a3a86a67c3fc8249ed305fc7b7d290ebe5e4d46ad45573884761ef4dea7b/certifi-2020.4.5.1.tar.gz";
        sha256 = "51fcb31174be6e6664c5f69e3e1691a2d72a1a12e90f872cbdb1567eb47b6519";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifiio.readthedocs.io/en/latest/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "chameleon" = python.mkDerivation {
      name = "chameleon-3.7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1d/3d/905ada571ea8ff9d5b2dac74a947e5f3fc875a491bdf453d2c47dc49f0d0/Chameleon-3.7.0.tar.gz";
        sha256 = "5e66ea02e5ca1b5d87f7baf6244eddabd8aa2f4e7f7f0a61c69d25a877add07e";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://chameleon.readthedocs.io";
        license = "BSD-like (http://repoze.org/license.html)";
        description = "Fast HTML/XML Template Compiler.";
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

    "colander" = python.mkDerivation {
      name = "colander-1.7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/db/e4/74ab06f54211917b41865cafc987ce511e35503de48da9bfe9358a1bdc3e/colander-1.7.0.tar.gz";
        sha256 = "d758163a22d22c39b9eaae049749a5cd503f341231a02ed95af480b1145e81f2";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [
        self."setuptools"
        self."wheel"
      ];
      propagatedBuildInputs = [
        self."iso8601"
        self."translationstring"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.pylonsproject.org/projects/colander/en/latest/";
        license = "BSD-derived (http://www.repoze.org/LICENSE.txt)";
        description = "A simple schema-based serialization and deserialization library";
      };
    };

    "dataclasses-json" = python.mkDerivation {
      name = "dataclasses-json-0.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/70/d2/138b0425d51a103d44fdcd775fef830dc1a829da338cd59040401d6d411c/dataclasses-json-0.4.2.tar.gz";
        sha256 = "65ac9ae2f7ec152ee01bf42c8c024736d4cd6f6fb761502dec92bd553931e3d9";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."marshmallow"
        self."marshmallow-enum"
        self."stringcase"
        self."typing-inspect"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/lidatong/dataclasses-json";
        license = licenses.mit;
        description = "Easily serialize dataclasses to and from JSON";
      };
    };

    "decorator" = python.mkDerivation {
      name = "decorator-4.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/da/93/84fa12f2dc341f8cf5f022ee09e109961055749df2d0c75c5f98746cfe6c/decorator-4.4.2.tar.gz";
        sha256 = "e3a62f0520172440ca0dcc823749319382e377f37f140a0b99ef45fecb84bfe7";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/micheles/decorator";
        license = licenses.bsdOriginal;
        description = "Decorators for Humans";
      };
    };

    "dectate" = python.mkDerivation {
      name = "dectate-0.14";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/67/3c/86eb41eac065a1148b00fb9c9e5c4d5ebf765121499c687c6f2ec8adf07b/dectate-0.14.tar.gz";
        sha256 = "56213abfe6ce31d6fe10dbf7a7cd94e07a26d5dc7cd0ae2e208c4ef2dbebb504";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://dectate.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "A configuration engine for Python frameworks";
      };
    };

    "deform" = python.mkDerivation {
      name = "deform-2.0.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/21/d0/45fdf891a82722c02fc2da319cf2d1ae6b5abf9e470ad3762135a895a868/deform-2.0.8.tar.gz";
        sha256 = "8936b70c622406eb8c8259c88841f19eb2996dffcf2bac123126ada851da7271";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."chameleon"
        self."colander"
        self."iso8601"
        self."peppercorn"
        self."translationstring"
        self."zope-deprecation"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.pylonsproject.org/projects/deform/en/latest/";
        license = "License :: Repoze Public License";
        description = "Form library with advanced features like nested forms";
      };
    };

    "eliot" = python.mkDerivation {
      name = "eliot-1.12.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/26/b5/f8fa5483623e4bda84d93ec1a5fa635470e84641d08dcf335d59724a27ce/eliot-1.12.0.tar.gz";
        sha256 = "b6e16d8a4392cac6bd07358aaef140c50059ab00fc13171012810e33e1d94b71";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."boltons"
        self."pyrsistent"
        self."six"
        self."zope-interface"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/itamarst/eliot/";
        license = licenses.asl20;
        description = "Logging library that tells you why it happened";
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

    "importscan" = python.mkDerivation {
      name = "importscan-0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/18/21/3a81623fc43ca4d476c0414729948bcb790059cd35b170612b2da534e94a/importscan-0.2.tar.gz";
        sha256 = "4fb19627e1349dfd7d49d9bbd1b1bfff0f0a13e884d6cf9dcaf16f865375c9b2";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://importscan.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Recursively import modules and sub-packages";
      };
    };

    "iso8601" = python.mkDerivation {
      name = "iso8601-0.1.12";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/45/13/3db24895497345fb44c4248c08b16da34a9eb02643cea2754b21b5ed08b0/iso8601-0.1.12.tar.gz";
        sha256 = "49c4b20e1f38aa5cf109ddcd39647ac419f928512c869dc01d5c7098eddede82";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/micktwomey/pyiso8601";
        license = licenses.mit;
        description = "Simple module to parse ISO 8601 dates";
      };
    };

    "itsdangerous" = python.mkDerivation {
      name = "itsdangerous-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/1a/f27de07a8a304ad5fa817bbe383d1238ac4396da447fa11ed937039fa04b/itsdangerous-1.1.0.tar.gz";
        sha256 = "321b033d07f2a4136d3ec762eac9f16a10ccd60f53c0c91af90217ace7ba1f19";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/itsdangerous/";
        license = licenses.bsdOriginal;
        description = "Various helpers to pass data to untrusted environments and back.";
      };
    };

    "jinja2" = python.mkDerivation {
      name = "jinja2-2.11.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/64/a7/45e11eebf2f15bf987c3bc11d37dcc838d9dc81250e67e4c5968f6008b6c/Jinja2-2.11.2.tar.gz";
        sha256 = "89aab215427ef59c34ad58735269eb58b1a5808103067f7bb9d5836c651b3bb0";
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

    "markdown" = python.mkDerivation {
      name = "markdown-2.6.11";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b3/73/fc5c850f44af5889192dff783b7b0d8f3fe8d30b65c8e3f78f8f0265fecf/Markdown-2.6.11.tar.gz";
        sha256 = "a856869c7ff079ad84a3e19cd87a64998350c2b94e9e08e44270faef33400f81";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://Python-Markdown.github.io/";
        license = licenses.bsdOriginal;
        description = "Python implementation of Markdown.";
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

    "marshmallow" = python.mkDerivation {
      name = "marshmallow-3.5.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/aa/36/13330d16fe173a53c18a3428b1c58a16ad07cacfdc13993dfac8f01301bf/marshmallow-3.5.2.tar.gz";
        sha256 = "56663fa1d5385c14c6a1236badd166d6dee987a5f64d2b6cc099dadf96eb4f09";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/marshmallow-code/marshmallow";
        license = licenses.mit;
        description = "A lightweight library for converting complex datatypes to and from native Python datatypes.";
      };
    };

    "marshmallow-enum" = python.mkDerivation {
      name = "marshmallow-enum-1.5.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8e/8c/ceecdce57dfd37913143087fffd15f38562a94f0d22823e3c66eac0dca31/marshmallow-enum-1.5.1.tar.gz";
        sha256 = "38e697e11f45a8e64b4a1e664000897c659b60aa57bfa18d44e226a9920b6e58";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."marshmallow"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = licenses.mit;
        description = "Enum field for Marshmallow";
      };
    };

    "more-babel-i18n" = python.mkDerivation {
      name = "more-babel-i18n-20.5.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7b/71/8e05aad1159ac5f38f2f35c4503c195d49ac9ef5157b09bbd3b57b395a5a/more.babel_i18n-20.5.0.tar.gz";
        sha256 = "9cbe0dca59bcafe0cc1c94262ea98ca7580e86ba38ff3b640a309ec7c8ed2ed1";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."babel"
        self."jinja2"
        self."morepath"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/dpausp/more.babel_i18n";
        license = licenses.bsdOriginal;
        description = "i18n/l10n support for Morepath applications and Jinja2 templates";
      };
    };

    "more-browser-session" = python.mkDerivation {
      name = "more-browser-session-19.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a0/e8/d9588492ffe4a8541daecac1454cbbb58d00fb0ecaca272e7c4a10d94c46/more.browser_session-19.8.0.tar.gz";
        sha256 = "80ebd95865a1270687d5bbb9f2dc3b6e7fe27f06a2711515278b74b534cfef55";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."itsdangerous"
        self."morepath"
        self."werkzeug"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/dpausp/more.browser_session";
        license = licenses.bsdOriginal;
        description = "Session support for Morepath applications";
      };
    };

    "more-forwarded" = python.mkDerivation {
      name = "more-forwarded-0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7c/d8/e14f30346a9da2dc705f2206a04c70d40dc03e8238f3a9ac4bb668aedb25/more.forwarded-0.2.tar.gz";
        sha256 = "d6e89b4990dc98fe4476d1dea3c49506a3434d5fc8118d48afaeecfcaa0595c3";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."morepath"
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/more.static";
        license = licenses.bsdOriginal;
        description = "Forwarded header support for Morepath";
      };
    };

    "more-itsdangerous" = python.mkDerivation {
      name = "more-itsdangerous-0.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/56/22/a423e8d148b628cf62f8bc8ec63ffdbda62258783e68c743c987321e68f0/more.itsdangerous-0.0.2.tar.gz";
        sha256 = "c0352ec418cb5f356261d88c600c18f7d7627895d357fe2f933fe643e42ba0f2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."itsdangerous"
        self."morepath"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/morepath/more.itsdangerous";
        license = licenses.bsdOriginal;
        description = "An identity policy for morepath using itsdangerous.";
      };
    };

    "more-transaction" = python.mkDerivation {
      name = "more-transaction-0.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/16/fa/764e2a21bf42a3f15f07144548ae00503a982b94f81f845732e090ffd652/more.transaction-0.9.tar.gz";
        sha256 = "b5ce7d11e6c71bb3b8b6eee060d25433e4ff7c377b5d42693d0be14a7a856ce6";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."morepath"
        self."setuptools"
        self."transaction"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/morepath/more.transaction";
        license = licenses.bsdOriginal;
        description = "transaction integration for Morepath";
      };
    };

    "morepath" = python.mkDerivation {
      name = "morepath-0.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fd/e0/d8c1a4ac30fa6e491d8340e793fd770609ca7384a0ec32291ebb68698fb4/morepath-0.19.tar.gz";
        sha256 = "3d3f075083766e7d9c1bd184bf927590e862caa8a385f9a8a572422c0d69606a";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."dectate"
        self."importscan"
        self."reg"
        self."setuptools"
        self."webob"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://morepath.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "A micro web-framework with superpowers";
      };
    };

    "munch" = python.mkDerivation {
      name = "munch-2.5.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/43/a1/ec48010724eedfe2add68eb7592a0d238590e14e08b95a4ffb3c7b2f0808/munch-2.5.0.tar.gz";
        sha256 = "2d735f6f24d4dba3417fa448cae40c6e896ec1fdab6cdb5e6510999758a4dbd2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Infinidat/munch";
        license = licenses.mit;
        description = "A dot-accessible dictionary (a la JavaScript objects)";
      };
    };

    "mypy-extensions" = python.mkDerivation {
      name = "mypy-extensions-0.4.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/63/60/0582ce2eaced55f65a4406fc97beba256de4b7a95a0034c6576458c6519f/mypy_extensions-0.4.3.tar.gz";
        sha256 = "2d82818f5bb3e369420cb3c4060a7970edba416647068eb4c5343488a6c604a8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/python/mypy_extensions";
        license = licenses.mit;
        description = "Experimental type system extensions for programs checked with the mypy typechecker.";
      };
    };

    "oauthlib" = python.mkDerivation {
      name = "oauthlib-3.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/c7/829c73c64d3749da7811c06319458e47f3461944da9d98bb4df1cb1598c2/oauthlib-3.1.0.tar.gz";
        sha256 = "bee41cc35fcca6e988463cacc3bcb8a96224f470ca547e697b604cc697b2f889";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/oauthlib/oauthlib";
        license = licenses.bsdOriginal;
        description = "A generic, spec-compliant, thorough implementation of the OAuth request-signing logic";
      };
    };

    "passlib" = python.mkDerivation {
      name = "passlib-1.7.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6d/6b/4bfca0c13506535289b58f9c9761d20f56ed89439bfe6b8e07416ce58ee1/passlib-1.7.2.tar.gz";
        sha256 = "8d666cef936198bc2ab47ee9b0410c94adf2ba798e5a84bf220be079ae7ab6a8";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/ecollins/passlib";
        license = licenses.bsdOriginal;
        description = "comprehensive password hashing framework supporting over 30 schemes";
      };
    };

    "peppercorn" = python.mkDerivation {
      name = "peppercorn-0.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e4/77/93085de7108cdf1a0b092ff443872a8f9442c736d7ddebdf2f27627935f4/peppercorn-0.6.tar.gz";
        sha256 = "96d7681d7a04545cfbaf2c6fb66de67b29cfc42421aa263e4c78f2cbb85be4c6";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.pylonsproject.org/projects/peppercorn/en/latest/";
        license = "BSD-derived (http://www.repoze.org/LICENSE.txt)";
        description = "A library for converting a token stream into a data structure for use in web form posts";
      };
    };

    "psycopg2" = python.mkDerivation {
      name = "psycopg2-2.8.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a8/8f/1c5690eebf148d1d1554fc00ccf9101e134636553dbb75bdfef4f85d7647/psycopg2-2.8.5.tar.gz";
        sha256 = "f7d46240f7a1ae1dd95aab38bd74f7428d46531f69219954266d669da60c0818";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://psycopg.org/";
        license = licenses.lgpl2;
        description = "psycopg2 - Python-PostgreSQL Database Adapter";
      };
    };

    "py-gfm" = python.mkDerivation {
      name = "py-gfm-0.1.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/06/ee/004a03a1d92bb386dae44f6dd087db541bc5093374f1637d4d4ae5596cc2/py-gfm-0.1.4.tar.gz";
        sha256 = "ef6750c579d26651cfd23968258b604228fd71b2a4e1f71dea3bea289e01377e";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."markdown"
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopieux/py-gfm";
        license = licenses.bsdOriginal;
        description = "An implementation of Github-Flavored Markdown written as an extension to the Python Markdown library.";
      };
    };

    "pyjade" = python.mkDerivation {
      name = "pyjade-4.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4a/04/396ec24e806fd3af7ea5d0f3cb6c7bbd4d00f7064712e4dd48f24c02ca95/pyjade-4.0.0.tar.gz";
        sha256 = "8d95b741de09c4942259fc3d1ad7b4f48166e69cef6f11c172e4b2c458b1ccd7";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/syrusakbary/pyjade";
        license = licenses.mit;
        description = "Jade syntax template adapter for Django, Jinja2, Mako and Tornado templates";
      };
    };

    "pyrsistent" = python.mkDerivation {
      name = "pyrsistent-0.16.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9f/0d/cbca4d0bbc5671822a59f270e4ce3f2195f8a899c97d0d5abb81b191efb5/pyrsistent-0.16.0.tar.gz";
        sha256 = "28669905fe725965daa16184933676547c5bb40a5153055a8dee2a4bd7933ad3";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/tobgu/pyrsistent/";
        license = licenses.mit;
        description = "Persistent/Functional/Immutable data structures";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2020.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f4/f6/94fee50f4d54f58637d4b9987a1b862aeb6cd969e73623e02c5c00755577/pytz-2020.1.tar.gz";
        sha256 = "c35965d010ce31b23eeb663ed3cc8c906275d6be1a34393a1d73a41febf4a048";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "pyyaml" = python.mkDerivation {
      name = "pyyaml-5.3.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/64/c2/b80047c7ac2478f9501676c988a5411ed5572f35d1beff9cae07d321512c/PyYAML-5.3.1.tar.gz";
        sha256 = "b8eac752c5e14d3eca0e6dd9199cd627518cb5ec06add0de9d32baeee6fe645d";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/yaml/pyyaml";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "reg" = python.mkDerivation {
      name = "reg-0.12";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/84/f7/35426ebde7d795998a086932d418fe0cafcf512d2e799c97a9de55e1e351/reg-0.12.tar.gz";
        sha256 = "e614db46d661d3967657b365fc82aba5f4cd7540d8d81a5fc77dc5adfb5e79f4";
};
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."repoze-lru"
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://reg.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Clever dispatch";
      };
    };

    "regex" = python.mkDerivation {
      name = "regex-2020.5.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/83/79/1a6a3996e2c607c094fb263d7227f7790544bc207cc39ee3640862c7732d/regex-2020.5.7.tar.gz";
        sha256 = "73a10404867b835f1b8a64253e4621908f0d71150eb4e97ab2e7e441b53e9451";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/mrabarnett/mrab-regex";
        license = licenses.psfl;
        description = "Alternative regular expression module, to replace re.";
      };
    };

    "repoze-lru" = python.mkDerivation {
      name = "repoze-lru-0.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/12/bc/595a77c4b5e204847fdf19268314ef59c85193a9dc9f83630fc459c0fee5/repoze.lru-0.7.tar.gz";
        sha256 = "0429a75e19380e4ed50c0694e26ac8819b4ea7851ee1fc7583c8572db80aff77";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.repoze.org";
        license = "License :: Repoze Public License";
        description = "A tiny LRU cache implementation and decorator";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.23.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f5/4f/280162d4bd4d8aad241a21aecff7a6e46891b905a4341e7ab549ebaf7915/requests-2.23.0.tar.gz";
        sha256 = "b3f43d496c6daba4493e7c431722aeb7dbc6288f52a6e04e7b6023b0247817e6";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."chardet"
        self."idna"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://requests.readthedocs.io";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "requests-oauthlib" = python.mkDerivation {
      name = "requests-oauthlib-1.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/23/eb/68fc8fa86e0f5789832f275c8289257d8dc44dbe93fce7ff819112b9df8f/requests-oauthlib-1.3.0.tar.gz";
        sha256 = "b4261601a71fd721a8bd6d7aa1cc1d6a8a93b4a9f5e96626f8e4d91e8beeaa6a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."oauthlib"
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/requests/requests-oauthlib";
        license = licenses.bsdOriginal;
        description = "OAuthlib authentication support for Requests.";
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
      name = "sqlalchemy-1.3.16";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7f/4b/adfb1f03da7f50db054a5b728d32dbfae8937754cfa159efa0216a3758d1/SQLAlchemy-1.3.16.tar.gz";
        sha256 = "7224e126c00b8178dfd227bc337ba5e754b197a3867d33b9f30dc0208f773d70";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.sqlalchemy.org";
        license = licenses.mit;
        description = "Database Abstraction Library";
      };
    };

    "sqlalchemy-searchable" = python.mkDerivation {
      name = "sqlalchemy-searchable-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/93/6e/9df05493d1bbc96eb1ca2c7ab87879a299399c9aa4ea73af52c159824884/SQLAlchemy-Searchable-1.1.0.tar.gz";
        sha256 = "b48e67ef238a154e4b8de84637ef9645c213a2367b1f1915dd2f65242b2f04b2";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."sqlalchemy"
        self."sqlalchemy-utils"
        self."validators"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kvesteri/sqlalchemy-searchable";
        license = licenses.bsdOriginal;
        description = "Provides fulltext search capabilities for declarative SQLAlchemy models.";
      };
    };

    "sqlalchemy-utils" = python.mkDerivation {
      name = "sqlalchemy-utils-0.36.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6e/a0/0ae3a246914f24dbd93be5f72aae75b79ea0831de629249b3532564d1061/SQLAlchemy-Utils-0.36.5.tar.gz";
        sha256 = "680068c4b671225c183815e19b6f4adc765a9989dd5d9e8e9c900ede30cc7434";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
        self."sqlalchemy"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kvesteri/sqlalchemy-utils";
        license = licenses.bsdOriginal;
        description = "Various utility functions for SQLAlchemy.";
      };
    };

    "stringcase" = python.mkDerivation {
      name = "stringcase-1.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f3/1f/1241aa3d66e8dc1612427b17885f5fcd9c9ee3079fc0d28e9a3aeeb36fa3/stringcase-1.2.0.tar.gz";
        sha256 = "48a06980661908efe8d9d34eab2b6c13aefa2163b3ced26972902e3bdfd87008";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/okunishinishi/python-stringcase";
        license = licenses.mit;
        description = "String case converter.";
      };
    };

    "transaction" = python.mkDerivation {
      name = "transaction-3.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4d/9a/f7c715eba8488e5b8ec0030aecd3065a7cfaf7b0a3fe6a466ec9d384c8d1/transaction-3.0.0.tar.gz";
        sha256 = "3b0ad400cb7fa25f95d1516756c4c4557bb78890510f69393ad0bd15869eaa2d";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."zope-interface"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/transaction";
        license = licenses.zpl21;
        description = "Transaction management for Python";
      };
    };

    "translationstring" = python.mkDerivation {
      name = "translationstring-1.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5e/eb/bee578cc150b44c653b63f5ebe258b5d0d812ddac12497e5f80fcad5d0b4/translationstring-1.3.tar.gz";
        sha256 = "4ee44cfa58c52ade8910ea0ebc3d2d84bdcad9fa0422405b1801ec9b9a65b72d";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pylonsproject.org";
        license = "BSD-like (http://repoze.org/license.html)";
        description = "Utility library for i18n relied on by various Repoze and Pyramid packages";
      };
    };

    "typing-extensions" = python.mkDerivation {
      name = "typing-extensions-3.7.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6a/28/d32852f2af6b5ead85d396249d5bdf450833f3a69896d76eb480d9c5e406/typing_extensions-3.7.4.2.tar.gz";
        sha256 = "79ee589a3caca649a9bfd2a8de4709837400dfa00b6cc81962a1e6a1815969ae";
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

    "typing-inspect" = python.mkDerivation {
      name = "typing-inspect-0.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/84/06/8610d429f5d8d6e145abd0ac6a1a6a120c5f6fcbe174d43ddde549b1c582/typing_inspect-0.6.0.tar.gz";
        sha256 = "8f1b1dd25908dbfd81d3bebc218011531e7ab614ba6e5bf7826d887c834afab7";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."mypy-extensions"
        self."typing-extensions"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ilevkivskyi/typing_inspect";
        license = licenses.mit;
        description = "Runtime inspection utilities for typing module.";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.25.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/05/8c/40cd6949373e23081b3ea20d5594ae523e681b6f472e600fbc95ed046a36/urllib3-1.25.9.tar.gz";
        sha256 = "3018294ebefce6572a474f0604c2021e33b3fd8006ecd11d62107a5d2a963527";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "validators" = python.mkDerivation {
      name = "validators-0.15.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c4/4a/4f9c892f9a9f08ee5f99c32bbd4297499099c2c5f7eff8c617a57d31a7d8/validators-0.15.0.tar.gz";
        sha256 = "31e8bb01b48b48940a021b8a9576b840f98fa06b91762ef921d02cb96d38727a";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."decorator"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kvesteri/validators";
        license = licenses.mit;
        description = "";
      };
    };

    "webob" = python.mkDerivation {
      name = "webob-1.8.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2a/32/5f3f43d0784bdd9392db0cb98434d7cd23a0d8a420c4d243ad4cb8517f2a/WebOb-1.8.6.tar.gz";
        sha256 = "aa3a917ed752ba3e0b242234b2a373f9c4e2a75d35291dcbe977649bd21fd108";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://webob.org/";
        license = licenses.mit;
        description = "WSGI request and response object";
      };
    };

    "werkzeug" = python.mkDerivation {
      name = "werkzeug-1.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/10/27/a33329150147594eff0ea4c33c2036c0eadd933141055be0ff911f7f8d04/Werkzeug-1.0.1.tar.gz";
        sha256 = "6c80b1e5ad3665290ea39320b91e1be1e0d5f60652b964a3070216de83d2e47c";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/werkzeug/";
        license = licenses.bsdOriginal;
        description = "The comprehensive WSGI web application library.";
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

    "zope-deprecation" = python.mkDerivation {
      name = "zope-deprecation-4.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/34/da/46e92d32d545dd067b9436279d84c339e8b16de2ca393d7b892bc1e1e9fd/zope.deprecation-4.4.0.tar.gz";
        sha256 = "0d453338f04bacf91bbfba545d8bcdf529aa829e67b705eac8c1a7fdce66e2df";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/zope.deprecation";
        license = licenses.zpl21;
        description = "Zope Deprecation Infrastructure";
      };
    };

    "zope-interface" = python.mkDerivation {
      name = "zope-interface-5.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/af/d2/9675302d7ced7ec721481f4bbecd28a390a8db4ff753d28c64057b975396/zope.interface-5.1.0.tar.gz";
        sha256 = "40e4c42bd27ed3c11b2c983fecfb03356fae1209de10686d03c02c8696a1d90e";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."setuptools"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/zope.interface";
        license = licenses.zpl21;
        description = "Interfaces for Python";
      };
    };

    "zope-sqlalchemy" = python.mkDerivation {
      name = "zope-sqlalchemy-1.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ba/1d/4ddb68ab3661c330b41a2b24f9c806b51e9f66cac5382c608f476bd5403b/zope.sqlalchemy-1.3.tar.gz";
        sha256 = "b9c689d39d83856b5a81ac45dbd3317762bf6a2b576c5dd13aaa2c56e0168154";
};
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."setuptools"
        self."sqlalchemy"
        self."transaction"
        self."zope-interface"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/zope.sqlalchemy";
        license = licenses.zpl21;
        description = "Minimal Zope/SQLAlchemy transaction integration";
      };
    };
  };
  localOverridesFile = ./install_requirements_override.nix;
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
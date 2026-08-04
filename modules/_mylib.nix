{ lib }:

let
  spaceSep = xs: lib.concatStringsSep " " xs;

  wrapProgram =
    pkg: attrs:
    let
      pkgs = attrs.pkgs;
      stdenv = pkgs.stdenv;
      shellArg = lib.escapeShellArg;
      mainProg = pkg.meta.mainProgram;

      runtimePkgsStr = spaceSep (
        map (pkg: "--prefix PATH : ${lib.makeBinPath pkg}") (attrs.runtimePkgs or [ ])
      );

      flagsStr = spaceSep (
        lib.mapAttrsToList (flag: value: "--add-flags ${shellArg "${flag} ${value}"}") (attrs.flags or { })
      );

      extraPrefixStr = spaceSep (
        lib.mapAttrsToList (k: v: "--prefix ${k} : ${shellArg v}") (attrs.extraPrefix or { })
      );

      chdirStr = lib.optionalString ((attrs.chdir or "") != "") "--chdir ${attrs.chdir}";
    in
    stdenv.mkDerivation {
      pname = "${pkg.pname or pkg.name}-wrapped";
      version = pkg.version or (pkg.meta.version or "unknown");

      nativeBuildInputs = [ pkgs.makeWrapper ];

      dontBuild = true;
      dontConfigure = true;
      dontUnpack = true;

      installPhase = ''
        runHook preInstall

        mkdir -p "$out/bin"
        cp ${pkg}/bin/${mainProg} "$out/bin/${mainProg}"
        wrapProgram $out/bin/${mainProg} ${flagsStr} ${runtimePkgsStr} ${extraPrefixStr} ${chdirStr}

        runHook postInstall
      '';
    };
in
{
  inherit wrapProgram;
}

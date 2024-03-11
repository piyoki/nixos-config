{ lib, ... }:

with builtins;
{
  sharedLib = {
    # (lib.path.append): Given a directory, return a flattened list of all files within it recursively.
    relativeToRoot = lib.path.append ../../.;
    # Scan a given directory and look for default.nix; import modules recursively
    scanPaths = path:
      map
        (f: (path + "/${f}"))
        (attrNames
          (lib.attrsets.filterAttrs
            (
              _path: _type:
                (_type == "directory") # include directories
            )
            (readDir path)));
  };
}

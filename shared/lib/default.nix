{ lib, ... }:

{
  sharedLib = {
    # (lib.path.append): Given a directory, return a flattened list of all files within it recursively.
    relativeToRoot = lib.path.append ../../.;
  };
}

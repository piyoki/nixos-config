_:

let
  mode = "0700";
  genDir = directory: { inherit directory mode; };
in
{
  commonSpecialDirs = [
    (genDir "flake")
    (genDir ".gnupg")
    (genDir ".ssh")
  ];
}

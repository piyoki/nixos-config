{ ... }:

{
  imports =
    map (d: ./apps + d)
      (map (n: "/" + n)
        (with builtins;attrNames
          (readDir ./apps)));
}

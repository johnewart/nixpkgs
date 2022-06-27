{ pkgs, ... }: {
  home.packages = with pkgs; [
    # latex
    rubber
    (texlive.combine {
      inherit (texlive)
        scheme-full

        # awesome cv
        xetex
        unicode-math
        ucharcat
        collection-fontsextra
        fontspec;
    })
  ];
}

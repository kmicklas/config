pkgs: {
  enableFontDir = true;
  enableGhostscriptFonts = true;
  fonts = with pkgs; [
    corefonts
    ubuntu_font_family
    unifont
    google-fonts
    font-droid
    source-han-sans-japanese
    source-han-sans-korean
    source-han-sans-simplified-chinese
    source-han-sans-traditional-chinese
  ];
}

pkgs: {
  enableFontDir = true;
  enableGhostscriptFonts = true;
  fonts = with pkgs; [
    corefonts
    ubuntu_font_family
    unifont
    google-fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-han-sans-japanese
    source-han-sans-korean
    source-han-sans-simplified-chinese
    source-han-sans-traditional-chinese
    wqy_microhei
    wqy_zenhei
  ];
}

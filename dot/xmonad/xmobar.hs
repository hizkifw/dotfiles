Config {
  font     = "xft:Fira Code:pixelsize=12,M+ 1c:pixelsize=12",
  position = BottomW C 100,
  bgColor  = "#131313",
  commands = [
    Run Date "%a %Y-%m-%d %H:%M:%S" "date" 10
--    Run Com "cat" "/sys/class/power_supply/BAT0/capacity" "battery" 10,
  ],
  sepChar  = "%",
  alignSep = "}{"
  template = "}{%date%"
}

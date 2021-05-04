Config {
  font     = "xft:Fira Code:pixelsize=12,M+ 1c:pixelsize=12",
  position = BottomW C 100,
  bgColor  = "#131313",
  commands = [
    Run Date "%a %Y-%m-%d %H:%M:%S" "date" 10,
    Run Battery [
      "-t", "<acstatus> <left>% <timeleft>",
      "--",
      "-O", "AC",
      "-o", "Bat",
      "-h", "green",
      "-l", "red"
    ] 10,
    Run StdinReader
  ],
  sepChar  = "%",
  alignSep = "}{"
  template = "%StdinReader% }{ %date% | %battery%"
}

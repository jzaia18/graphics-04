load "Utils.rb"

$OUTFILE = "image.ppm"

# Draw a circle
i = 0
while i < $TAU
  Utils.line_directed(250, 250, i, 250, r: i*100, g: i*120, b: i*150)
  i+= 0.01
end

Utils.write_out($OUTFILE)

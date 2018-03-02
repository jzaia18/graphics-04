require './Draw.rb'
require './Utils.rb'
require './MatrixUtils.rb'
require './Matrix.rb'

include Math

##TAU!!!!
$TAU = PI*2

# Changeable
$RESOLUTION = 500 # All images are squares
$DEBUGGING = false
$BACKGROUND_COLOR = [0, 0, 0] # [r, g, b]
$DRAW_COLOR = [200, 0, 0]
$INFILE = "script"
$OUTFILE = "image.ppm"
$TEMPFILE = "temmmmp.ppm" # Used as temp storage for displaying

# Static
$GRID = Utils.create_grid()
$TRAN_MAT = MatrixUtils.identity(4) # Transformations matrix
$EDGE_MAT = Matrix.new(4, 0) # Edge matrix
$RC = $DRAW_COLOR[0] # Red component
$GC = $DRAW_COLOR[1]
$BC = $DRAW_COLOR[2]

##=================== MAIN ==========================
# i = 0
# while i < $TAU
#   Draw.add_edge(100, 100, 100*i, 100*cos(i) + 100, 100*sin(i) + 100, 100*i)
#   i += 0.01
# end

Utils.parse_file()

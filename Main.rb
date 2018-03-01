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
$OUTFILE = "image.ppm"
$TEMPFILE = "temmmmp.ppm" #Used as temp storage for displaying

# Static
$GRID = Utils.create_grid()
$TRAN_MAT = MatrixUtils.identity(4)
$EDGE_MAT = Matrix.new(4, 0) # An edge matrix
$RC = $DRAW_COLOR[0]
$GC = $DRAW_COLOR[1]
$BC = $DRAW_COLOR[2]

##========================== MAIN ==========================


## TEST matrix functionality
mat = Matrix.new(4, 0)

puts mat

mat.add_col([1, 2, 3, 4])
mat.add_col([1, 2, 3, 4])
mat.add_col([1, 2, 3, 4])
mat.add_col([1, 2, 3, 4])
mat.add_col([1, 2, 3, 4])
mat.add_col([1, 2, 3, 4])

puts "Test matrix"
puts mat

a = MatrixUtils.identity(4)

puts "Test identity matrix"
puts a

puts "Get 2 specific indices:"
puts a.get(1,1)
puts a.get(1,0)
puts "Get a row"
puts a.get_row(1).to_s
puts "Get a collumn"
puts a.get_col(1).to_s

puts "\nMultiplying by the identity..."
puts MatrixUtils.multiply(a, mat)
puts "\nAdding it to itself..."
puts MatrixUtils.add(mat, mat)
puts "\nSubtracting it from itself..."
puts MatrixUtils.subtract(mat, mat)


## TEST edge matrices

i = 0
while i <= $RESOLUTION
  Draw.add_edge(i, 0, 0, i, $RESOLUTION, 0)
  Draw.add_edge(0, i, 0, $RESOLUTION, i, 0)
  i += 20
end

Draw.push_edge_matrix()
Utils.write_out()

Utils.parse_file('script')

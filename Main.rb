require './Draw.rb'
require './MatrixUtils.rb'
require './Matrix.rb'

include Math

##TAU!!!!
$TAU = PI*2

$RESOLUTION = 500 # All images are squares
$DEBUGGING = false
$BACKGROUND_COLOR = [0, 0, 0] # [r, g, b]
$OUTFILE = "image.ppm"
$GRID = Draw.create_board()
$EDGE_MAT = Matrix.new(4, 0) # An edge matrix


## Write GRID to OUTFILE
def self.write_out(file)
  file = File.open(file, 'w')
  file.puts "P3 #$RESOLUTION #$RESOLUTION 255" #Header in 1 line
  for row in $GRID
    for pixel in row
      for rgb in pixel
        file.print rgb
        file.print ' '
      end
      file.print '   '
    end
    file.puts ''
  end
  file.close()
end

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
write_out($OUTFILE)

include Math

module Utils

  def self.create_grid()## Create board
    board = Array.new($RESOLUTION)
    for i in (0...$RESOLUTION)
      board[i] = Array.new($RESOLUTION)
      for j in (0...$RESOLUTION)
        board[i][j] = $BACKGROUND_COLOR
      end
    end
    return board
  end


  ## Write GRID to OUTFILE
  def self.write_out(file: $OUTFILE, edgemat: $EDGE_MAT)
    Draw.push_edge_matrix(edgemat: edgemat)
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

  def self.display(tempfile: $TEMPFILE)
    write_out(file: tempfile)
    puts %x[display #{tempfile}]
    puts %x[rm #{tempfile}]
  end

  def self.apply_transformations(edge_mat: $EDGE_MAT, tran_mat: $TRAN_MAT)
    edge_mat = MatrixUtils.multiply(tran_mat, edge_mat)
  end

  def self.parse_file(filename: $INFILE)
    file = File.new(filename, "r")
    while (line = file.gets)
      line = line.chomp
      puts "LINE: " + line
      case line
      when "display"
        display();
      when "ident"
        $TRAN_MAT = MatrixUtils.identity(4)
      when "line"
        args = file.gets.chomp.split(" ")
        for i in (0...6); args[i] = args[i].to_i end
        Draw.add_edge(args[0], args[1], args[2], args[3], args[4], args[5])
      when "save"
        arg = file.gets.chomp
        write_out(file: arg)
      else
        puts "Unrecognized command: " + line
      end
    end
    file.close
  end

end

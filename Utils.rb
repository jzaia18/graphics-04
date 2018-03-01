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
  def self.write_out(file: $OUTFILE)
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

  def self.parse_file(filename)
    file = File.new(filename, "r")
    while (line = file.gets)
      case line
      when 'display'
        display();
      else
        puts "Unrecognized command: " + line
      end
    end
    file.close
  end

end

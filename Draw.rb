require './MatrixUtils.rb'

module Draw

  def self.create_board()## Create board
    board = Array.new($RESOLUTION)
    for i in (0...$RESOLUTION)
      board[i] = Array.new($RESOLUTION)
      for j in (0...$RESOLUTION)
        board[i][j] = $BACKGROUND_COLOR
      end
    end
    return board
  end

  # Plot a point on GRID (from top left)
  def self.plot(x, y, r: 255, g: 255, b: 255) $GRID[y%$RESOLUTION][x%$RESOLUTION] = [r.floor, g.floor, b.floor] end
  # Plot a point on GRID (from bottom left)
  def self.plot_bot(x, y, r: 255, g: 255, b: 255) plot(x%$RESOLUTION, ($RESOLUTION - y)%$RESOLUTION, r: r, g: g, b: b) end

  # Define a line by 2 points
  def self.line(x0, y0, x1, y1, r: 255, g: 255, b: 255)
    # x0 is always left of x1
    line(x1, y1, x0, y0, r: r, g: g, b: b) if x1 < x0

    #init vars
    dy = y1-y0
    dx = x1-x0
    x = x0
    y = y0
    d = -1 * dx

    ## Begin actual algorithm:
    if dy <= 0 #if the line is in octants I or II
      if dy.abs <= dx #octant I
        puts "Drawing line in Octant I" if $DEBUGGING
        while x <= x1
          plot(x, y, r: r, g: g, b: b)
          if d > 0
            y-=1
            d-=2*dx
          end
          x+=1
          d-=2*dy
        end

      else #octant II
        puts "Drawing line in Octant II" if $DEBUGGING
        while y >= y1
          plot(x, y, r: r, g: g, b: b)
          if d > 0
            x+=1
            d+=2*dy
          end
          y-=1
          d+=2*dx
        end
      end

    else #if the line is in octants VII or VIII

      if dy >= dx #octant VII
        puts "Drawing line in Octant VII" if $DEBUGGING
        while y <= y1
          plot(x, y, r: r, g: g, b: b)
          if d > 0
            x+=1
            d-=2*dy
          end
          y+=1
          d+=2*dx
        end

      else #octant VIII
        puts "Drawing line in Octant VIII" if $DEBUGGING
        while x <= x1
          plot(x, y, r: r, g: g, b: b)
          if d > 0
            y+=1
            d-=2*dx
          end
          x+=1
          d+=2*dy
        end
      end
    end
  end

  # Define a line by a point, angle and length
  def self.line_directed(x0, y0, dir, len, r: 255, g: 255, b: 255, cast_down:true)
    x1 = len * Math.cos(dir) + x0
    y1 = len * Math.sin(dir) + y0
    if cast_down
      x1 = x1.floor
      y1 = y1.floor
    else
      x1 = x1.ceil
      y1 = y1.ceil
    end
    line(x0, y0, x1, y1, r: r, g: g, b: b)
  end

  # Helper for add_edge
  def self.add_point(x, y, z)
    $EDGE_MAT.add_col([x, y, z, 1])
  end

  # Add an edge to the global edge matrix
  def self.add_edge(x0, y0, z0, x1, y1, z1)
    add_point(x0, y0, z0)
    add_point(x1, y1, z1)
  end

  # Draw the pixels in the matrix and clean it out
  def self.push_edge_matrix()
    i = 0
    while i < $EDGE_MAT.cols
      coord0 = $EDGE_MAT.get_col(i)
      coord1 = $EDGE_MAT.get_col(i + 1)
      line(coord0[0], coord0[1], coord1[0], coord1[1])
      i+=2
    end
    $EDGE_MAT = Matrix.new(4, 0)
  end

end

module Utils

  ## Global Variables
  include Math

  ##TAU!!!!
  $TAU = PI*2

  $RESOLUTION = 500 # All images are squares
  $GRID = Array.new($RESOLUTION)
  $DEBUGGING = false
  $BACKGROUND_COLOR = [0, 0, 0] # [r, g, b]


  ## Create board
  for i in (0...$RESOLUTION)
    $GRID[i] = Array.new($RESOLUTION)
    for j in (0...$RESOLUTION)
      $GRID[i][j] = $BACKGROUND_COLOR
    end
  end

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


  # Plot a point on GRID (from top left)
  def self.plot(x, y, r: 255, g: 255, b: 255) $GRID[y%$RESOLUTION][x%$RESOLUTION] = [r.floor, g.floor, b.floor] end
  # Plot a point on GRID (from bottom left)
  def self.plot_bot(x, y, r: 255, g: 255, b: 255) plot(x%$RESOLUTION, ($RESOLUTION - y)%$RESOLUTION, r: r, g: g, b: b) end

  # Define a line by 2 points
  def self.line(x0, y0, x1, y1, r: 255, g: 255, b: 255)
    # x0 is always left of x1
    if x1 < x0; line(x1, y1, x0, y0, r: r, g: g, b: b) else

      #init vars
      dy = y1-y0
      dx = x1-x0
      x = x0
      y = y0
      d = 2*dy - dx

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
  end

  ## Uses 1 while loop. It's actually slower than the other line function.
  def self.lineINTEGRATED(x0, y0, x1, y1, r: 255, g: 255, b: 255)
    # x0 is always left of x1
    if x1 < x0; line(x1, y1, x0, y0, r: r, g: g, b: b) else

      #init vars
      dy = y1 - y0
      dx = x1 - x0

      # incrvar = nil    #either x or y, constantly changes by 1
      # dynamicvar = nil #either x or y, may or may not change
      # stoppoint = nil  #the point to stop at (incrvar's counterpart)
      # incrd = nil      #what to increment d by each iteration
      # dynamicd = nil   #what to increment d by on occaision
      # octant = nil     #the octant the line is in

      d = 2 * dy - dx

      if dy<0
        if dy.abs < dx;
          puts "Drawing line in Octant I" if $DEBUGGING
          octant = 1
          incrvar = x0
          dynamicvar = y0
          incrd = -2 * dy
          dynamicd = -2 * dx
          stoppoint = x1
        else
          puts "Drawing line in Octant II" if $DEBUGGING
          octant = 2
          incrvar = y0
          dynamicvar = x0
          incrd = 2 * dx
          dynamicd = 2 * dy
          stoppoint = y1
        end
      else
        if dy > dx;
          puts "Drawing line in Octant VII" if $DEBUGGING
          octant = 7
          incrvar = y0
          dynamicvar = x0
          incrd = 2 * dx
          dynamicd = -2 * dy
          stoppoint = y1
        else
          puts "Drawing line in Octant VIII" if $DEBUGGING
          octant = 8
          incrvar = x0
          dynamicvar = y0
          incrd = 2 * dy
          dynamicd = -2 * dx
          stoppoint = x1
        end
      end

      while (incrvar - stoppoint).abs > 0
        plot(incrvar, dynamicvar, r: r, g: g, b: b) if octant == 1 or octant == 8
        plot(dynamicvar, incrvar, r: r, g: g, b: b) if octant == 2 or octant == 7
        if d > 0
          if octant == 1; dynamicvar-= 1 else
            dynamicvar += 1 end
          d+= dynamicd
        end
        if octant == 2; incrvar -= 1 else
          incrvar += 1 end
        d+= incrd
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

  ##========================== MAIN ==========================

  ##~~~~~~~~~~~~~~~~~~~ Test cases ~~~~~~~~~~~~~~~~~~~
  #  line(250, 250, 499, 240, r:0) #Octant I
  #  line(250, 250, 499, 200, r:0) #Octant I
  #  line(250, 250, 499, 150, r:0) #Octant I
  #  line(250, 250, 260, 0, g:0) #Octant II
  #  line(250, 250, 350, 0, g:0) #Octant II
  #  line(250, 250, 400, 0, g:0) #Octant II
  #  line(250, 250, 260, 499, b:0) #Octant VII
  #  line(250, 250, 290, 499, b:0) #Octant VII
  #  line(250, 250, 400, 499, b:0) #Octant VII
  #  line(250, 250, 499, 275) #Octant VIII
  #  line(250, 250, 499, 400) #Octant VIII
  #  line(250, 250, 499, 450) #Octant VIII

  # ## literal edge cases
  #  line(0, 499, 499, 0, r:0) #Octant II edge
  #  line(250, 499, 250, 0, g:0) #Octant II edge
  #  line(0, 0, 499, 499, b:0) #Octant VIII edge
  #  line(0, 250, 499, 250) #Octant VIII edge

  ##~~~~~~~~~~~~~~~~~~~ Cool Image to show in Gallery ~~~~~~~~~~~~~~~~~~~

  # # Draw a circle
  # i = 0
  # while i < TAU
  #   line_directed(250, 250, i, 250, r: i*100, g: i*120, b: i*150)
  #   i+= 0.01
  # end

  # # Hollow out the center
  # i = 0
  # while i < TAU
  #   line_directed(250, 250, i, 75, r: 0, g: 0, b: 0)
  #   i+= 0.00125 # Needs more precision
  # end

  # write_out()

end

module MatrixUtils

  # Create an identity matrix of side-length size
  def self.identity(size)
    ret = Matrix.new(size, size)
    for i in (0...size)
      ret.set(i, i, 1)
    end
    return ret
  end

  # Multiplies 2 matricies (dot product) and returns result
  def self.multiply(m1, m2)
    raise "Cannot multiply these matricies due to their dimensions" if m1.cols != m2.rows
    ret = Matrix.new(m1.rows, m2.cols)
    for r in (0...ret.rows)
      for c in (0...ret.cols)
        sum = 0
        for i in (0...m1.rows) # Get the dot product and sum it
          sum += m1.get_row(r)[i] * m2.get_col(c)[i] end
        ret.set(r, c, sum)
      end
    end
    return ret
  end

  # Adds 2 matricies and returns result
  def self.add(m1, m2)
    raise "Cannot add these matricies due to their dimensions" if m1.rows != m2.rows || m1.cols != m2.cols
    ret = Matrix.new(m1.rows, m1.cols)
    for r in (0...m1.rows)
      for c in (0...m1.cols)
        ret.set(r, c, m1.get(r, c) + m2.get(r, c))
      end
    end
    return ret
  end

  def self.subtract(m1, m2)
    raise "Cannot subtract these matricies due to their dimensions" if m1.rows != m2.rows || m1.cols != m2.cols
    ret = Matrix.new(m1.rows, m1.cols)
    for r in (0...m1.rows)
      for c in (0...m1.cols)
        ret.set(r, c, m1.get(r, c) - m2.get(r, c))
      end
    end
    return ret
  end

end

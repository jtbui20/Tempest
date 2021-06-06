class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x.to_f
    @y = y.to_f
  end

  def +(other)
    raise TypeError, "no implicit conversion of #{other.class} into Point" unless other.is_a?(Point)

    Point.new(x + other.x, y + other.y)
  end

  def -(other)
    raise TypeError, "no implicit conversion of #{other.class} into Point" unless other.is_a?(Point)

    Point.new(x - other.x, y - other.y)
  end

  def *(other)
    if other.is_a?(Float) || other.is_a?(Integer)
      Point.new(x * other, y * other)
    elsif other.is_a?(Point)
      (x * other.x) + (y * other.y)
    else
      raise TypeError, "no implicit conversion of #{other.class} into Point"
    end
  end

  def /(other)
    if other.is_a?(Float) || other.is_a?(Integer)
      Point.new(x / other, y / other)
    else
      raise TypeError, "no implicit conversion of #{other.class} into Point"
    end
  end

  def <(other)
    raise TypeError, "no implicit conversion of #{other.class} into Point" unless other.is_a?(Point)

    (x < other.x && y < other.y)
  end

  def <=(other)
    raise TypeError, "no implicit conversion of #{other.class} into Point" unless other.is_a?(Point)

    (x <= other.x && y <= other.y)
  end

  def >(other)
    raise TypeError, "no implicit conversion of #{other.class} into Point" unless other.is_a?(Point)

    (x > other.x && y > other.y)
  end

  def >=(other)
    raise TypeError, "no implicit conversion of #{other.class} into Point" unless other.is_a?(Point)

    (x >= other.x && y >= other.y)
  end

  def direction
    return self * (1 / magnitude) if magnitude != 0

    self
  end

  def magnitude
    Math.hypot(x, y)
  end

  def distance_to(point)
    (self - point).magnitude
  end

  def within_radius?(point, radius)
    distance_to(point) < radius
  end

  # Opt out
  def angle_between_vector(point, degree = true, true_zero = true)
    out = Math.acos((self * point) / (self.magnitude * point.magnitude))
    out = (degree) ? out * (180 / Math::PI) : out
    out = (true_zero) ? ((self.y < 0) ? -1 * out : out) : out
    out.round(2)
  end
end

if __FILE__ == $0
  a = Point.new(1, 0)
  b = Point.new(1, 0)
  puts a.angle_between_vector(b, true, true)
  puts a * b
end
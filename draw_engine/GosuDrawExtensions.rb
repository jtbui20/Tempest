require 'gosu'

def draw_quad_simp(points, colors, layer)
  colors.push(colors.last) while colors.size < 4
  Gosu.draw_quad(
    points[0].x, points[0].y, colors[0],
    points[1].x, points[1].y, colors[1],
    points[2].x, points[2].y, colors[2],
    points[3].x, points[3].y, colors[3],
    layer
  )
end

def draw_quad_two_point(pointA, pointB, colors, layer)
  colors.push(colors.last) while colors.size < 4
  Gosu.draw_quad(
    pointA.x, pointA.y, colors[0],
    pointB.x, pointA.y, colors[1],
    pointB.x, pointB.y, colors[2],
    pointA.x, pointB.y, colors[3],
    layer
  )
end

def draw_path(center, points, color, layer)
  (points.size - 1).times.each { |i|
    Gosu.draw_triangle(
      center.x, center.y, color,
      points[i - 1].x, points[i - 1].y, color,
      points[i].x, points[i].y,
      color, layer
    )
  }
end

def draw_line_simp(start_point, end_point, color, layer); end
require 'gosu'
require_relative 'Point'

class Grid
  attr_accessor :grid

  def initialize(tile, width, height, screen_width, screen_height)
    @grid = []
    @tile = tile
    @width_offset = @tile.width / 2
    @height_offset = (@tile.height / 2) - 2
    @screen_width = screen_width
    @screen_height = screen_height

    (0...width).each do |x|
      (0...height).each do |y|
        @grid.push(Point.new(
                     (@screen_width / 2) - (@width_offset * (x + 1)) + (@width_offset * y), @height_offset * y + (@height_offset * x)
                   ))
      end
    end
  end

  def draw
    @grid.each do |tile|
      @tile.draw(tile.x, tile.y, 0, 1, 1)
    end
  end
end

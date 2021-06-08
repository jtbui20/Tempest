require 'gosu'
require_relative 'Layers'
require_relative 'Point'

class IsoGrid
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
        @grid << Point.new(
          (@screen_width / 2) - (@width_offset * (x + 1)) + (@width_offset * y), 
           @height_offset * y + (@height_offset * x))
      end
    end
  end

  def draw()
    @grid.each { | tile| @tile.draw(tile.x, tile.y, Layers::BACKGROUND, 1, 1) }
  end
end

class TopDownGrid
  attr_accessor :grid

  def initialize(tile, width, height, screen_width, screen_height, scale_x = 0.7, scale_y = 0.7)
    @grid = []
    @tile = tile
    @screen_width = screen_width
    @screen_height = screen_height
    @scale_x = scale_x
    @scale_y = scale_y

    (0...width).each do |x|
      (0...height).each do |y|
        @grid << Point.new(
          @screen_width / 2 + (@scale_x * tile.width * (x - (height / 2).to_f)),
          @screen_height / 2 + (@scale_y * tile.height * (y - (width / 2).to_f))
      )
      end
    end
  end

  def draw()
    @grid.each { |tile| @tile.draw(tile.x, tile.y, Layers::BACKGROUND, @scale_x, @scale_y)}
  end
end
require 'gosu'
require_relative './GosuDrawExtensions'
require_relative './Point'
require_relative './Layers'

class Button
  attr_accessor :position, :dimensions, :color_fg, :color_bg, :click, :text

  def initialize(x, y, w, h, text = '', on_click = nil)
    @position = Point.new(x, y)
    @dimensions = Point.new(w, h)

    @color_fg = 0xff_000000
    @color_bg = 0xff_ffffff

    @font = Gosu::Font.new(50)
    @text = text

    @click = on_click
  end

  def draw
    @corners = []
               .push(@position)
               .push(@position + Point.new(0, @dimensions.y))
               .push(@position + @dimensions)
               .push(@position + Point.new(@dimensions.x, 0))
    draw_quad_simp(@corners, [@color_bg], Layers::UI)

    center = @position + (@dimensions / 2)
    @font.draw_text_rel(@text, center.x, center.y, Layers::UI, 0.5, 0.5, 1, 1, @color_fg)
  end
end

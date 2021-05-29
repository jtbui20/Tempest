require 'gosu'
require_relative './GosuDrawExtensions'
require_relative './Point'
require_relative './Layers'
require './game_engine/Object'

class Button < GameObject
  attr_accessor :position, :dimensions, :color_fg, :color_bg, :click, :text

  def initialize(name, master, position, dimensions, text = '', on_click = nil)
    super(name, master)

    @position = position
    @dimensions = dimensions

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

class ProgressBar < GameObject
  attr_accessor :positions, :dimensions, :color_fg, :color_bg, :min, :max, :value

  def initialize (name, master, position, dimensions, follow_min, follow_max, follow_value)
    @position = position
    @dimensions = dimensions

    @min = follow_min
    @max = follow_max
    @value = follow_value
  end

  def draw
    value_complete = (@value.call - @min.call).to_f / @max.call - @min.call
    @corners = []
               .push(@position)
               .push(@position + Point.new(0, @dimensions.y))
               .push(@position + @dimensions)
               .push(@position + Point.new(@dimensions.x, 0))
    @corners_progress = []
               .push(@position)
               .push(@position + Point.new(0, @dimensions.y))
               .push(@position + Point.new(@dimensions.x * value_complete, @dimensions.y))
               .push(@position + Point.new(@dimensions.x * value_complete, 0))

    draw_quad_simp(@corners, [0xff_ffffff], Layers::UI)
    draw_quad_simp(@corners_progress, [0xff_00ff00], Layers::UI)
  end
end

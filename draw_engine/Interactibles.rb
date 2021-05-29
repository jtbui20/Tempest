require 'gosu'
require_relative './GosuDrawExtensions'
require_relative './Point'
require_relative './Layers'
require './game_engine/Object'
require './draw_engine/Collider.rb'

class Button < GameObject
  attr_accessor :position, :dimensions, :color_fg, :color_bg, :click, :text

  def initialize(name, master, position, dimensions, text = '', on_click = nil)
    super(name, master, position, Layers::UI)
    @dimensions = dimensions

    @color_fg = 0xff_000000
    @color_bg = 0xff_ffffff

    @font = Gosu::Font.new(50)
    @text = text

    @click = on_click
    @collider = Collider.new(master, position, dimensions, [])
  end

  def draw
    @corners = []
               .push(@position)
               .push(@position + Point.new(0, @dimensions.y))
               .push(@position + @dimensions)
               .push(@position + Point.new(@dimensions.x, 0))
    draw_quad_simp(@corners, [@color_bg], @layer)

    center = @position + (@dimensions / 2)
    @font.draw_text_rel(@text, center.x, center.y, @layer, 0.5, 0.5, 1, 1, @color_fg)
  end
end

# Specific CircleSelect Buttons
class ButtonImg < GameObject
  attr_accessor :position, :dimensions, :click, :text

  def initialize(name, master, position, img, anchor, on_click = nil)
    @img = img
    @dimensions = Point.new(img.width, img.height)

    @anchor = anchor
    case anchor
    when TOP_LEFT
      p = position
    when TOP_CENTER
      p = position - Point.new(@dimensions.x / 2, 0) 
    when TOP_RIGHT
      p = position - Point.new(@dimensions.x, 0)
    when CENTER_LEFT
      p = position - Point.new(0, @dimensions.y / 2)
    when CENTER
      p = position - (@dimensions / 2)
    when CENTER_RIGHT
      p = position - Point.new(@dimensions.x, @dimensions.y / 2)
    when BOTTOM_LEFT
      p = position - Point.new(0, @dimensions.y)
    when BOTTOM_CENTER
      p = position - Point.new(@dimensions.x / 2, @dimensions.y)
    when BOTTOM_RIGHT
      p = position - @dimensions
    end

    super(name, master, position, Layers::UI)
    @click = on_click

    @collider = Collider.new(master, position, dimensions, [])
  end

  def draw
    @img.draw(@position.x, @position.y, @layer, 1, 1)
  end
end

class ProgressBar < GameObject
  attr_accessor :positions, :dimensions, :color_fg, :color_bg, :min, :max, :value

  def initialize (name, master, position, dimensions, follow_min, follow_max, follow_value)
    super(name, master, position, Layers::UI)
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

    draw_quad_simp(@corners, [0xff_ffffff], @layer)
    draw_quad_simp(@corners_progress, [0xff_00ff00], @layer)
  end
end

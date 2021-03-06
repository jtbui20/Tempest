# * UI.rb defines various reusable skeleton components with default behaviours in order to quickly produce functional elements.
# * This aids designers, who are not specifically proficient in programming, but can understand each of the attributes which depicts a button.
# * The decision to use OOP Principles: Encapsulation, was justified by the large quantity of UI elements. This was the perfect scenario
# * to demonstrate modularity.

# ? Built on Tasks 3.3C - Shape Drawing and 5.3C - Hover / Reactive Button.

require 'gosu'
require_relative './GosuDrawExtensions'
require_relative './Point'
require_relative './Layers'
require './game_engine/Object'
require './draw_engine/Collider.rb'

# ! This will be depricated in the UI update
class Button < GameObject
  attr_accessor :position, :dimensions, :color_fg, :color_bg, :click, :text, :enabled, :hover

    # ! Condense to options file
  def initialize(name, master, position, dimensions, text = '', on_click = nil, hover = true)
    super(name, master, position, Layers::UI)
    @dimensions = dimensions

    @color_fg = 0xff_000000
    @color_bg = 0xff_ffffff

    @state = 0

    @font = Gosu::Font.new(50)
    @text = text
    @enabled = true
    @hover = hover

    # * This allows an event handler to operate on this button. Rather than defining it within the object itself, it is assigned a
    # * function that it calls upon achieving the state.
    @click = on_click
    @collider = Collider.new(master, position, dimensions, [])
    self
  end

  def draw()
    @corners = []
               .push(@position)
               .push(@position + Point.new(0, @dimensions.y))
               .push(@position + @dimensions)
               .push(@position + Point.new(@dimensions.x, 0))
    draw_quad_simp(@corners, [@color_bg], @layer)

    center = @position + (@dimensions / 2)
    @font.draw_text_rel(@text, center.x, center.y, @layer, 0.5, 0.5, 1, 1, @color_fg)
  end

  def click_down()
    @color_bg = 0xff_707070
  end

  def on_hover_enter()
    @color_bg = 0xff_dedede
  end

  def on_hover_exit()
    @color_bg = 0xff_ffffff
  end
end

class Text < GameObject
  attr_accessor :position, :dimensions, :text, :hover

  def initialize(name, master, position, size, text)
    super(name, master, position, Layers::UI)
    @font = Gosu::Font.new(size)
    @hover = false

    @text = text
  end

  def draw()
    @font.draw_text(@text.call, @position.x, @position.y, @layer, 1, 1, 0xff_000000)
  end
end

# ! Specific CircleSelect Buttons
class ButtonImg < GameObject
  attr_accessor :position, :dimensions, :click, :text

  def initialize(name, master, position, img, anchor, on_click = nil)
    @img = img
    @dimensions = Point.new(img.width, img.height)

    # ! Make anchor default for all GameObjects
    @anchor = anchor
    case anchor
    when TOP_LEFT
      pa = position
    when TOP_CENTER
      pa = position - Point.new(@dimensions.x / 2, 0) 
    when TOP_RIGHT
      pa = position - Point.new(@dimensions.x, 0)
    when CENTER_LEFT
      pa = position - Point.new(0, @dimensions.y / 2)
    when CENTER
      pa = position - (@dimensions / 2)
    when CENTER_RIGHT
      pa = position - Point.new(@dimensions.x, @dimensions.y / 2)
    when BOTTOM_LEFT
      pa = position - Point.new(0, @dimensions.y)
    when BOTTOM_CENTER
      pa = position - Point.new(@dimensions.x / 2, @dimensions.y)
    when BOTTOM_RIGHT
      pa = position - @dimensions
    end

    super(name, master, position, Layers::UI)
    
    @click = on_click

    @collider = Collider.new(master, position, dimensions, [])
  end

  def draw()
    @img.draw(@position.x, @position.y, @layer, 1, 1)
  end
end

class ProgressBar < GameObject
  attr_accessor :positions, :dimensions, :color_fg, :color_bg, :min, :max, :value, :hover

  def initialize (name, master, position, dimensions, direction, follow_min, follow_max, follow_value, color_norm, color_30)
    super(name, master, position, Layers::UI)
    @dimensions = dimensions

    @min = follow_min
    @max = follow_max
    @value = follow_value
    @color_norm = color_norm
    @color_30 = color_30

    @hover = false

    @img = Gosu::Image.new("./assets/hp_bar.png")
    @padding = Point.new(9, 7)
    @direction = direction
  end

  def draw()
    value_complete = (@value.call - @min.call).to_f / @max.call - @min.call
    @corners = []
               .push(@position)
               .push(@position + Point.new(0, @dimensions.y))
               .push(@position + @dimensions)
               .push(@position + Point.new(@dimensions.x, 0))
    @img.draw(@position.x, @position.y, @layer)

    @corners_progress = []
               .push(@position + @padding)
               .push(@position + @padding + Point.new(0, @dimensions.y))
               .push(@position + @padding + Point.new(@dimensions.x * value_complete, @dimensions.y))
               .push(@position + @padding + Point.new(@dimensions.x * value_complete, 0))

    if @direction == 0
      @corners_progress = []
               .push(@position + @padding + Point.new(@dimensions.x - @dimensions.x * value_complete, 0))
               .push(@position + @padding + Point.new(@dimensions.x, 0))
               .push(@position + @padding + @dimensions)
               .push(@position + @padding + Point.new(@dimensions.x - @dimensions.x * value_complete, @dimensions.y))
    end

    # draw_quad_simp(@corners, [0xff_ffffff], @layer)
    draw_quad_simp(@corners_progress, [(value_complete <= 0.3) ? @color_30 : @color_norm], @layer)
  end
end
class Frame < GameObject
  attr_accessor :position, :dimensions, :color, :click, :text, :enabled, :hover, :click

  def initialize(name, master, position, dimensions, color = 0xff_ffffff, click= -> (_) {})
    super(name, master, position, Layers::UI)

    @dimensions = dimensions
    @hover = true
    
    @color = color
    @click = click
  end

  def draw()
    @corners = []
               .push(@position)
               .push(@position + Point.new(0, @dimensions.y))
               .push(@position + @dimensions)
               .push(@position + Point.new(@dimensions.x, 0))
    draw_quad_simp(@corners, [@color], @layer)
  end

  def on_hover_enter(); end
  def on_hover_exit(); end
end

class Image < GameObject
  attr_accessor :position, :dimensions, :hover

  def initialize(name, mmaster, position, src, scale = Point.new(1,1))
    super(name, master, position, Layers::UI)
    @img = Gosu::Image.new(src)
    @dimensions = Point.new(@img.width, @img.height)
    @position = position
    @scale = scale

    @hover = false
  end

  def draw()
    @img.draw(@position.x, @position.y, Layers::UI, @scale.x, @scale.y)
  end
end
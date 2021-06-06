require './draw_engine/Layers'
require './game_engine/Object'

class Scene
  attr_reader :name, :draw_func, :elements, :master, :is_clickable, :mouse_pos

  def initialize(name, master)
    @name = name
    @draw_func = method(:draw)
    @master = master
    @elements = []
    @mouse_pos = nil

    @is_clickable = true
    @full_init = false
  end

  def set_mouse(x,y)
    @mouse_pos = Point.new(x,y)
  end

  def set_frame_time(fps)
    @delta_time = (fps == 0) ? 0 : 1.0 / fps
  end

  def draw; 
    self.get_elements.each &:draw
  end

  def update; 
    collidables = @elements.filter{ |c| defined?(c.collider)}
    collidables.each { |i| i.collider.collider_update(collidables - [i])}
    handle_mouse_UI(:hover)
    @elements.each &:update
  end

  def handle_mouse_UI (action)
    self.get_elements.filter { |i| i.layer == Layers::UI}.reverse.each do |element|
      if element.hover
        if element.position <= @mouse_pos && @mouse_pos <= (element.position + element.dimensions)
          if action == :click
            return element.click.call(element)
          elsif action == :hover
            return element.on_hover_enter
          end
        else
          if action == :hover
            element.on_hover_exit
          end
        end
      end
    end
  end

  def button_down(id); 
    if id == Gosu::MS_LEFT
      handle_mouse_UI(:click)
    end
  end

  def add_element(*arg)
    @elements += arg
    self
  end

  def remove_element(*arg)
    @elements -= arg
    self
  end

  def get_elements
    out = []
    @elements.each do |element|
      if element.is_a?(Group)
        out += element.elements
      else
        out << element
      end
    end
    return out
  end

  def find_in_scene(name)
    return @elements.reject {|item| item.name != name}
  end
end

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

  def draw; 
    @elements.each &:draw
  end

  def update; end

  def button_down(id); 
    if id == Gosu::MS_LEFT
      @elements.reverse.each do |element|
        if element.position <= @mouse_pos && @mouse_pos <= (element.position + element.dimensions)
          return element.click.call(element)
        end
      end
    end
  end

  def add_element(item)
    @elements.push(item)
  end

  def remove_element(item)
    @elements.delete(item)
  end

  def find_in_scene(name)
    return @elements.reject {|item| item.name != name}
  end
end

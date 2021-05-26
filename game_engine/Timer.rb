require 'gosu'

class Timer
  def initialize (duration = nil, finish = nil)
    @start = Gosu.milliseconds
    @duration = duration.nil? ? finish - @start : duration
    @finish = finish.nil? ? @start + duration : finish
    @remaining = duration
    @running = true
  end

  def complete?
    Gosu.milliseconds >= @finish || @remaining == 0
  end

  def running?; return @running; end

  def update
    unless complete?
      @remaining = @finish - Gosu.milliseconds
    end

    if complete?; @running = false; end
  end

  def restart_now 
    @start = Gosu.milliseconds
    @finish = @start + @duration
    @remaining = @duration 
    @running = true
  end
end
require 'gosu'

# The timer object defines various reusable timers that operate in the program.
# The decision to use Object Orientated Programming Concepts 
class Timer
  def initialize (duration = nil, finish = nil, allow_pause=false)
    start(duration, finish)
    @pausable = allow_pause
  end

  def complete?; @remaining == 0 || @elapsed == @duration; end

  def running?; return @running; end

  def enabled?; return @enabled; end

  def get_remaining; return @remaining; end

  def start(duration = nil, finish = nil)
    @start = Gosu.milliseconds

    if @duration.nil?
      @duration = duration.nil? ? finish - @start : duration
      @finish = finish.nil? ? @start + duration : finish
    else
      @finish = @start + @duration
    end

    @remaining = duration
    @elapsed = 0

    @paused_time = @start
    @preElapsed = 0

    @enabled = true
    @running = true
  end

  def update
    # Clock runs if enabled & not complete
    if @enabled
      unless self.complete?
        # Pausable timers require halting time & halt progress
        if @pausable
          if self.running?
            @elapsed = Gosu.milliseconds - @paused_time + @preElapsed
            @remaining = @duration - @elapsed
          end
        else
          @elapsed = Gosu.milliseconds - @start
          @remaining = @duration - @elapsed
        end

        @elapsed = @duration if @elapsed > @duration
        @remaining = 0 if @remaining < 0
      end
    end

    if self.complete?
      @running = false
      @enabled = false
    end
  end

  def pause
    if @pausable && self.running?
      @running = false
      @preElapsed = @elapsed
    end
  end

  def resume
    if @pausable && !self.running?
      @running = true
      @paused_time = Gosu.milliseconds
    end
  end

  def restart_now 
    start(@duration)
  end
  
  def milliseconds_to_minutes (milli) seconds_to_minutes milliseconds_to_seconds milli; end
  def milliseconds_to_seconds (milli) (milli == 0) ? 0 : (milli * 0.001).round(0); end
  def seconds_to_milliseconds (seconds) seconds * 1000; end
end
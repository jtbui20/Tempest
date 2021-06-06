module WizardAnimData
  class FrameData
    attr_reader :start, :duration
    def initialize(start, duration)
      @start = start
      @duration = duration
    end
  end
  ID = {
    :RunUp => FrameData.new(0, 10),
    :KickUp => FrameData.new(10, 7), # Delay 4f
    :RunDown => FrameData.new(21, 10),
    :KickDown => FrameData.new(32, 11),
    :RunSide => FrameData.new(42, 10),
    :KickSide => FrameData.new(52, 9), # Delay 2f
    :SummonDown => FrameData.new(63, 9), # Delay 2f
    :SlamDown => FrameData.new(73, 11),
    :SummonUp => FrameData.new(84, 11),
    :SlamUp => FrameData.new(95, 10), # Delay 1f
    :SummonSide => FrameData.new(105, 12),
    :Dash_Side => FrameData.new(117, 8),
    :SwingDown => FrameData.new(126, 9),
    :SideSlide => FrameData.new(141, 3),
    :SwingDownAlt => FrameData.new(147, 9),
    :SideSlideAlt => FrameData.new(167, 3),
    :SwingUp => FrameData.new(173, 11),
    :SwingUpAlt => FrameData.new(194, 12),
    :IdleDown => FrameData.new(210, 1),
    :IdleSide => FrameData.new(211, 1),
    :IdleUp => FrameData.new(212, 1),
  }
end
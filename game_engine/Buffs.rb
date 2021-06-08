# * Ported modifer & buff management from AK-SIM / DL-SIM
# ? https://github.com/dl-stuff/dl/blob/master/core/modifier.py by Mushymato
# ? AK-SIM by James Bui in reference to DL-SIM

class ModifierDict < Hash
  def initialize(*arg, **kwargs)
    unless arg.nil?
      super(*arg, **kwargs)
    else super
    end
  end

  def getModifiers
    self.map { |key, _| key}
  end

  def <<(other)
    if self[other.stat].nil?; 
      self[other.stat] = [] << other
    else
      self[other.stat] << other
    end
  end

  def >>(other)
    self[other.stat].delete(other)
  end

  def get_total(stat)
    out = 1
    unless self[stat].nil?
      self[stat].each {|other| out *= other.value}
    end
    out
  end
end

class Modifier
  attr_accessor :name, :stat, :value, :active
  def initialize(g_mods, name, stat, value)
    @g_mods = g_mods
    @name = name
    @stat = stat
    @value = value
    @active = false
  end

  def to_s()
    "#{@name}: #{stat} - #{value} [#{active}]"
  end

  def set_global(mods)
    @g_mods = mods
  end

  def on()
    unless @active
      @active = true
      @g_mods << self
    end
    # ! add duration refresh
    return
  end

  def off()
    if @active
      @active = false
      @g_mods >> self
    end
    return
  end
end

class Buff
  attr_reader :name, :align, :duration
  def initialize(name, align, duration, *arg)
    @name = name
    @align = align
    @duration = duration
    @active = false
    # ! Timeline? or Timer?
    @mods = arg
    # ? self.on
  end

  def to_s
    "#{@name}: #{@duration}\n" + @mods.map { |i| i.to_s}.join("\n")
  end

  def on(gmods)
    unless @active
      @active = true
      @mods.each do |mod|
        mod.set_global(gmods)
        mod.on
      end
    end
    # ! add duration refresh?
    return
  end

  def off()
    if @active
      @active = false
      @mods.each &:off
    end
    return
  end
end
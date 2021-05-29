module Element
  Flame, Water, Wind, Earth, Light, Shadow = *0..5
  def self.key(value)
    case value
    when 0; "Flame"
    when 1; "Water"
    when 2; "Wind"
    when 3; "Earth"
    when 4; "Light"
    when 5; "Shadow"
    else nil
    end
  end
end

module ClassType
  Augmenter, Mage, Summoner = *0..2
end

module Stats
  HP, MP, ATK, DEF, HASTE, AGI = *0..5

  def self.key(value)
    case value
    when 0; "HP"
    when 1; "MP"
    when 2; "ATK"
    when 3; "DEF"
    when 4; "HASTE"
    when 5; "AGI"
    else nil
    end
  end
end

module SpellType
  Slash, Barrier, Movement, Projectile, Buff, Debuff = *0..5
end

# Ported modifier / buff management
# ! AKSIM / DL-SIM

class ModifierDict < Hash
  def initialize(*args, **kwargs)
    unless args.nil?;  super(*args, **kwargs)
    else super(nil)
    end
  end

  def getModifiers
    return self.map { |key, value| key}
  end
end

class BuffList < Array
  def initialize(*args, **kwargs)
    unless args.nil?; super(*args, **kwargs)
    else super(nil)
    end
  end
end

class Modifier
  def initialize(name, stat, operand, value)
    @name = name
    @stat = stat
    @operand = operand
    @value = value
    @active = false
    # ? self.on
  end

  def on
    unless self.active
      self.active = true
      # * self.mod_dict.append(self)
    end
    return
  end

  def off
    if self.active
      self.active = false
      # * self.mod_dict.remove(self)
    end
    return
  end
end

class Buff
  def initialize(name, duration, stat, operand, value)
    @name = name
    @duration = duration
    @stat = stat
    @operand = operand
    @value = value
    @active = false
    # ! Timeline? or Timer?
    self.modifier = Modifier.new(name, stat, operand, value)
  end

  # * Off on like MModifier
end

class CharacterStats
  # Inputs
  # Boon / Bane stats - [key, value]
  # Boon / Bane elements
  # Class
  attr_accessor :hp, :HP_
  def initialize (class_type, mod_stat, mod_element)
    default_stats()
    default_element()

    @mod = ModifierDict.new(0)
    @mod["hi"] = 0
    @mod["help"] = 0
    @mod.getModifiers

    @class_type = class_type
    
    mod_stat.each do |stat, is_buff, value|
      puts "#{stat}, #{is_buff}, #{value}"
    end
  end

  def default_stats
    @hp = 1000
    @hp_min = 0
    @hp_max = 1000
    @mp = 200
    @mp_min = 0
    @mp_max = 100
    @atk = 100
    @def = 1
    @haste = 1
    @agi = 1
  end

  def default_element
    @ELE_ATK_FLAME = 1
    @ELE_ATK_WATER = 1
    @ELE_ATK_WIND = 1
    @ELE_ATK_EARTH = 1
    @ELE_ATK_LIGHT = 1
    @ELE_ATK_SHADOW = 1

    @ELE_RES_FLAME = 1
    @ELE_RES_WATER = 1
    @ELE_RES_WIND = 1
    @ELE_RES_EARTH = 1
    @ELE_RES_LIGHT = 1
    @ELE_RES_SHADOW = 1
  end

  # Observer Access
  def get_hp; return @hp; end
  def symbol_hp; return method(:get_hp); end
  def get_hp_min; return @hp_min; end
  def symbol_hp_min; return method(:get_hp_min); end
  def get_hp_max; return @hp_max; end
  def symbol_hp_max; return method(:get_hp_max); end
  def get_mp ; return @mp; end
  def symbol_mp; return method(:get_mp); end
  def get_mp_min; return @mp_min; end
  def symbol_mp_min; return method(:get_mp_min); end
  def get_mp_max; return @mp_max; end
  def symbol_mp_max; return method(:get_mp_max); end
  def get_atk; return @atk; end
  def symbol_atk; return method(:get_atk); end
  def get_def; return @def; end
  def symbol_def; return method(:get_def); end
  def get_haste; return @haste; end
  def symbol_haste; return method(:get_haste); end
  def get_agi; return @agi; end
  def symbol_agi; return method(:get_agi); end
end
module Difficulty
  BEGINNER,
  INTERMEDIATE,
  MASTER,
  NIGHTMARE,
  OMEMGA = *0..4
end

module Element
  Flame,
  Water,
  Wind,
  Earth,
  Light,
  Shadow = *0..5
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
  Augmenter,
  Mage,
  Summoner = *0..2
  def self.key(value)
    case value
    when 0; "Augmenter"
    when 1; "Mage"
    when 2; "Summoner"
    else nil
    end
  end
end

module Stats
  HP,
  MP,
  ATK,
  DEF,
  HASTE,
  AGI = *0..5

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
  Slash,
  Barrier,
  Movement,
  Projectile,
  Buff,
  Debuff = *0..5

  def self.key(value)
    case value
    when 0; "Slash"
    when 1; "Barier"
    when 2; "Movement"
    when 3; "Projectile"
    when 4; "Buff"
    when 5; "Debuff"
    else nil
    end
  end
end
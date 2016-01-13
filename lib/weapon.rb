
# require 'BattleBot'

class Weapon

    attr_reader  :name, :damage, :bot

    def initialize( weapon_name, damage = 10 )
        raise ArgumentError unless weapon_name.is_a? String
        raise ArgumentError unless damage.is_a? Fixnum
        
        @name = weapon_name
        @damage = damage
        @bot = nil
    end

    def bot= (new_bot)
        raise ArgumentError unless new_bot.is_a?( BattleBot ) || new_bot == nil
        @bot = new_bot
    end

    def picked_up?
        @bot.is_a? BattleBot
    end

end

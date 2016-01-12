
# require_relative 'BattleBot'

class Weapon

    def attr_reader :name, :damage
    def attr_accessor :bot

    def initialize( weapon_name, damage = 10 )
        raise ArgumentError unless weapon_name.is_a String
        raise ArgumentError unless damage.is_a Fixnum
        
        @name = weapon_name
        @damage = damage
        @bot = nil
    end

    def name
        @name
    end
    
    def damage
        @damage
    end

    def bot
        @bot
    end

    def bot= (new_bot)
        raise ArgumentError unless new_bot.is_a( BattleBot ) || new_bot == nil
        @bot = new_bot
    end

    def picked_up

    end


end


require 'weapon'

class BattleBot
    @@count = 0

    attr_reader :name, :health, :enemies, :weapon
    def initialize(name)
        @name = name
        @health = 100
        @enemies = []
        @weapon = nil
        @dead = false
        @@count += 1
    end

    def self.count
        @@count
    end

    def pick_up (new_weapon)
        raise ArgumentError unless new_weapon.is_a? Weapon
        raise ArgumentError if new_weapon.bot.is_a? BattleBot
        if @weapon == nil
            @weapon = new_weapon    
            new_weapon.bot = self
            new_weapon
        else
            nil
        end
    end

    def drop_weapon
        @weapon.bot = nil
        @weapon = nil
    end

    def take_damage( damage )
        raise ArgumentError unless damage.is_a? Fixnum
        if ! @dead 
            @health = [ @health - damage, 0 ].max 
            if @health == 0
                @dead = true
                @@count -= 1
            end
        end
        @health
    end

    def heal
        if ! @dead
            @health = [ @health + 10, 100 ].min
        end
        @health
    end


    def attack (victim_bot)
        raise ArgumentError unless victim_bot.is_a? BattleBot
        raise ArgumentError if victim_bot == self
        raise ArgumentError if weapon == nil

        victim_bot.receive_attack_from( self )
    end

    def receive_attack_from (enemy_bot)
        raise ArgumentError unless enemy_bot.is_a? BattleBot
        raise ArgumentError if enemy_bot == self
        raise ArgumentError if enemy_bot.weapon == nil

        take_damage( enemy_bot.weapon.damage )
        if !( @enemies.include? enemy_bot )
            @enemies << enemy_bot
        end

        defend_against(enemy_bot)
    end

    def defend_against( enemy_bot )
        if !dead? && has_weapon?
            attack(enemy_bot)
        end
    end

    def has_weapon?
        weapon != nil
    end

    def dead?
        @dead
    end

    private
    def health= (s)
        @health = s
    end

end



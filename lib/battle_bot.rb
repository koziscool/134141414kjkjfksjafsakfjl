
# require 'weapon'

class BattleBot

    def initialize(name)
        @name = name
        @health = 100
        @enemies = []
        @weapon = nil
        @dead = false

        @@count = 0
    end

    def count
        @@count
    end

    def name
        @name
    end

    def name= (s)
        @name = s
    end

    def health
        @health
    end

    def health= (s)
        @health = s
        if @health == 0
            @dead = true
            @@count -= 1
        end
    end

    def enemies
        @enemies
    end

    def enemies= (s)
        @enemies = s
    end

    def weapon
        @weapon
    end

    def pick_up (new_weapon)
        raise ArgumentError unless new_weapon.is_a Weapon
        if @weapon == nil
            @weapon = new_weapon    
            new_weapon.bot = self
        end
    end

    def drop_weapon
        @weapon.bot = nil
        @weapon = nil
    end

    def take_damage( damage )
        raise ArgumentError unless damage.is_a Fixnum
        if ! @dead 
            health = [ health - damage, 0 ].max
            health
        end
    end

    def heal( benefit )
        raise ArgumentError unless benefit.is_a Fixnum
        if ! @dead
            health = [ health + benefit, 100 ].min
            health
        end
    end


    def attack (victim_bot)
        raise ArgumentError unless victim_bot.is_a BattleBot
        raise ArgumentError if victim_bot == self
        raise ArgumentError if weapon != nil

        victim_bot.receive_attack_from( self )
    end

    def receive_attack_from (enemy_bot)
        raise ArgumentError unless enemy_bot.is_a BattleBot
        raise ArgumentError if enemy_bot == self
        raise ArgumentError if enemy_bot.weapon != nil

        take_damage.enemy_bot.weapon.damage
        if !( @enemies.include? enemy_bot )
            @enemies << enemy_bot
        end

        defend_against(enemy_bot)
    end

    def defend_against
        if !dead? && has_weapon?
            attack(enemy_bot)
        end
    end

    def has_weapon?
        weapon != nil
    end

    def dead?
        dead
    end

end



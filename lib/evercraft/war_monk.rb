module Evercraft
  class WarMonk < Character
  	def hit_points_per_level
  		6
  	end

  	def armor_class
  		@armor_class + modifier(:dexterity) + modifier(:wisdom)
  	end

  	def calculate_damage(critical_hit)
			if critical_hit
				6 + (modifier(:strength) * 2)
			else
				3 + modifier(:strength)
			end
  	end

  	def calculate_attack_modifier(level)
  		(1..level).inject(0) do |sum, num|
  			if num % 2 == 0 or num % 3 == 0
  				sum + 1
  			else
  				sum
  			end 
  		end
  	end
  end
end
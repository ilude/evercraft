module Evercraft
  class Rogue < Character
   	def calculate_damage(critical_hit)
			if critical_hit
				3 + (modifier(:strength) * 3)
			else
				1 + modifier(:strength)
			end
  	end

  	def calculated_armor_class(opponent)
  		opponent_dex_modifier = opponent.modifier(:dexterity)
  		if opponent_dex_modifier > 0
  			opponent.armor_class - opponent_dex_modifier
  		else
  			opponent.armor_class
	  	end
  	end

  	def modified_attack_roll(attack_dice_value)
  		attack_dice_value + modifier(:dexterity)
  	end
  end
end
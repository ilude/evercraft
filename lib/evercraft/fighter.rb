module Evercraft
  class Fighter < Character
  	def calculate_attack_modifier(level)
  		level - 1
  	end

  	def hit_points_per_level
  		10
  	end
  end
end
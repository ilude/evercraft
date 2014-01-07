module Evercraft
  class Paladin < Character
  	def hit_points_per_level
  		8
  	end

  	def calculated_armor_class(opponent)
  		if(opponent.alignment.eql? :evil)
  			super(opponent) -2
  		else
  			super(opponent)
  		end
  	end

  	def calculate_damage(opponent, critical_hit)
  		if(opponent.alignment.eql? :evil)
  			super(opponent, critical_hit) + 2
  		else
  			super(opponent, critical_hit)
  		end
  	end
  end
end
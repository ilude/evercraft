module Evercraft
  class Character
  	attr_reader :damage, :level
  	attr_accessor :name, :alignment, :armor_class, :hit_points, :experience, :attack_modifier
  	#attr_accessor :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma


  	def self.ability(*abilities)
  		@@abilities = abilities

  		abilities.each do |ability|
	  		# Getter
	  		define_method(ability) do
	  			instance_variable_get(("@#{ability}").to_sym)
	  		end

	  		# Setter
	  		define_method(ability.to_s + '=') do |value|
	  			raise InvalidArgument if value <= 0 || value > 20
	  			instance_variable_set(("@#{ability}").to_sym, value)
	  		end
  		end
  	end

  	ability :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma

  	def initialize()
  		@name = 'unknown'
  		@alignment = :neutral
  		@armor_class = 10

  		@@abilities.each do |ability|
				self.send(ability.to_s + '=', 10)  			
  		end

  		@damage = 0
  		self.hit_points = hit_points_per_level

  		@experience = 0
  		@level = 1
  		@attack_modifier = 0
  	end

  	def add_points(value)
  		@hit_points += value + modifier(:constitution)
  	end

  	def add_attack_modifier(value)
  		@attack_modifier += value
  	end

  	def hit_points
  		effective_hit_points = @hit_points + modifier(:constitution)
  		effective_hit_points = effective_hit_points < 1 ? 1 : effective_hit_points
  		effective_hit_points - @damage 
  	end

  	def hit_points_per_level
  		5
  	end

  	def damage(value)
  		@damage += value
  	end

  	def alignment=(val)
  		valid_alignments = [:good, :neutral, :evil]
  		if valid_alignments.include? val
  			@alignment = val
  		else
  			raise InvalidArgument
  		end
  	end

  	def armor_class
  		@armor_class + modifier(:dexterity)
  	end

  	def calculated_armor_class(opponent)
  		opponent.armor_class 
  	end

  	def modified_attack_roll(attack_dice_value)
  		attack_dice_value + modifier(:strength)
  	end

  	def attack(opponent, attack_dice_value)
  		# check for critical hit
  		critical_hit = attack_dice_value == 20

  		success = calculated_armor_class(opponent) <= modified_attack_roll(attack_dice_value)
  		
  		puts "Attack successful? #{success}"

  		damage = calculate_damage(critical_hit).to_i
  		damage = 1 if damage <= 0

  		opponent.damage(damage) if success
  		@experience += 10 if success

  		success
  	end

  	def calculate_damage(critical_hit = false)
			if critical_hit
				2 + (modifier(:strength) * 2)
			else
				1 + modifier(:strength)  				
			end
  	end

  	def add_experience(amount)
  		@experience += amount

  		calculated_level = (@experience / 1000).to_i + 1
  		if(calculated_level > @level) 
  			level_change = calculated_level - @level
  			add_points(hit_points_per_level * level_change)
  			#add_attack_modifier((level_change / 2).to_i)
  			@attack_modifier = calculate_attack_modifier(calculated_level)
  			@level = calculated_level
  		end
  	end

  	def calculate_attack_modifier(level)
  		(level / 2).floor
  	end

  	def alive?
			hit_points > 0  		
  	end

  	def modifier(ability)
  		(self.send(ability) / 2).to_i - 5 
  	end
  end
end
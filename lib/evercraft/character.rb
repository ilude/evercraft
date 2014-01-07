module Evercraft
  class Character
  	attr_accessor :name, :alignment, :armor_class, :hit_points
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

	  		# Set default value to 10
	  		#instance_variable_set("@#{ability}".to_sym, 10)
  		end
  	end

  	ability :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma
  
  	def initialize()
  		@name = 'unknown'
  		@alignment = :neutral
  		@armor_class = 10
  		@hit_points = 5

  		#self.create_abilities

  		@@abilities.each do |ability|
				self.send(ability.to_s + '=', 10)  			
  		end

  		#@strength = 10
  		#@dexterity = 10
  		#@constitution = 10
  		#@wisdom = 10
  		#@intelligence = 10
  		#@charisma = 10
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

  	def hit_points
  		@hit_points + modifier(:constitution)
  		@hit_points = @hit_points < 1 ? 1 : @hit_points 
  	end

  	def attack(opponent, attack_dice_value)
  		# check for critical hit
  		critical_hit = attack_dice_value == 20

  		modified_attack_roll = attack_dice_value + modifier(:strength)
  		success = opponent.armor_class <= modified_attack_roll
  		
  		puts "Attack successful? #{success}"

  		damage = 0
  		if success
  			if critical_hit
  				puts "Critical Hit!"
  				damage = 2 + (modifier(:strength) * 2)
  			else
  				damage = 1 + modifier(:strength)  				
  			end

  			damage = 1 if damage <= 0 
  		end

  		puts "Damage: #{damage}"

  		opponent.hit_points -= damage

  		#opponent.hit_points -= 1 + modifier(:strength) if success?
  		#opponent.hit_points -= 1 if critical_hit?
  		success
  	end

  	def alive?
			@hit_points > 0  		
  	end

  	def modifier(ability)
  		(self.send(ability) / 2).to_i - 5 
  	end
  end
end
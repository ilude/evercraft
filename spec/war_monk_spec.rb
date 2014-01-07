require 'helper'

describe Evercraft::WarMonk do
	it "gains 6 hit points per level instead of 5" do
		subject.add_experience(2000)
		subject.level.should eql 3
		subject.hit_points.should eql 18
	end

	it "does 3 points of damage instead of 1 on successful attack" do
			opponent = Evercraft::Character.new
			attack_dice = 15

			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 2 
	end

	it "adds wisdom and dexterity modifier to AC" do
		subject.dexterity = 15 # +2
		subject.wisdom = 15 # +2

		subject.armor_class.should eql 14
	end

	it "gains 1 to attack_modifier on even levels" do
		subject.add_experience(1000)
		subject.level.should eql 2
		subject.attack_modifier.should eql 1
	end

	it "doesn't gain 1 to attaack modifier on levels that aren't divisible by 2 or 3" do
		subject.add_experience(4000)
		subject.level.should eql 5
		subject.attack_modifier.should eql 3
	end

	it "attack modifier is 2 for level 3" do
		subject.add_experience(2000)
		subject.level.should eql 3
		subject.attack_modifier.should eql 2
	end

	it "attack modifier is 3 for level 4" do
		subject.add_experience(3000)
		subject.level.should eql 4
		subject.attack_modifier.should eql 3
	end

	it "attack modifier is 4 for level 6" do
		subject.add_experience(5000)
		subject.level.should eql 6
		subject.attack_modifier.should eql 4
	end
end
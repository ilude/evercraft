require 'helper'

describe Evercraft::Rogue do
	it "does triple damage on critical hit" do
		opponent = Evercraft::Character.new
		attack_dice = 20

		subject.attack(opponent, attack_dice)

		opponent.hit_points.should eql 2
	end

	it "ignores an opponents dex modifier to AC when attacking" do
		opponent = Evercraft::Character.new
		opponent.dexterity = 15  # +2
		attack_dice = 10

		subject.attack(opponent, attack_dice).should be_true		
	end

	it "does not add negative dexterity modifier when attacking" do
		
		opponent = Evercraft::Character.new
		opponent.dexterity = 7  # -2
		attack_dice = 8

		subject.attack(opponent, attack_dice).should be_true		
	end
	
	it "adds dexterity modifier when attacking" do
		opponent = Evercraft::Character.new
		subject.dexterity = 15  # +2
		attack_dice = 8

		subject.attack(opponent, attack_dice).should be_true		
	end

	
	it "add negative dexterity modifier when attacking" do
		opponent = Evercraft::Character.new
		subject.dexterity = 7  # -2
		attack_dice = 11

		subject.attack(opponent, attack_dice).should be_false		
	end

end
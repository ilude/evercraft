require 'helper'

describe Evercraft::Paladin do
	it "gains 8 hit points per level" do
		subject.add_experience(2000)
		subject.level.should eql 3
		subject.hit_points.should eql 24
	end

	it "gain +2 to attack_modifier aginst evil opponent" do
		opponent = Evercraft::Character.new
		opponent.alignment = :evil

		attack_dice = 9

		subject.attack(opponent, attack_dice).should be_true
	end

	it "adds 2 damage aginst evil opponent" do
		opponent = Evercraft::Character.new
		opponent.alignment = :evil

		attack_dice = 9

		subject.attack(opponent, attack_dice)

		opponent.hit_points.should eql 2
	end
end
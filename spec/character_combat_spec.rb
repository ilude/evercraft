require 'helper'

describe Evercraft::Character, "Combat" do

	context "combat" do
		it "attack must beat opponents armor class" do
			opponent = Evercraft::Character.new
			attack_dice = 12

			result = subject.attack(opponent, attack_dice)
			result.should eql true
		end

		it "attack can also meet opponents armor class" do
			opponent = Evercraft::Character.new
			attack_dice = 10

			result = subject.attack(opponent, attack_dice)
			result.should eql true
		end

		it "attack fails if dice value is less than opponent's armor class" do
			opponent = Evercraft::Character.new
			attack_dice = 9

			result = subject.attack(opponent, attack_dice)
			result.should eql false
		end

		it "can damage opponent" do
			opponent = Evercraft::Character.new
			attack_dice = 15

			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 4 
		end

		it "if the attack fails, no damage should be taken" do
			opponent = Evercraft::Character.new
			attack_dice = 9

			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 5 
		end

		it "if roll is a natural 20, it is a critical hit and damange is doubled" do
			opponent = Evercraft::Character.new
			attack_dice = 20

			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 3
		end		

		it "can kill opponent" do
			opponent = Evercraft::Character.new
			attack_dice = 20

			subject.attack(opponent, attack_dice)
			subject.attack(opponent, attack_dice)
			subject.attack(opponent, attack_dice)

			opponent.alive?.should eql false

		end

		it "will be alive if greater than zero" do
			opponent = Evercraft::Character.new
			opponent.alive?.should be_true

			attack_dice = 20
			subject.attack(opponent, attack_dice)

			opponent.alive?.should be_true
		end

		it "applies modifiers to combat attack roll" do
			opponent = Evercraft::Character.new
			
			attack_dice = 9

			subject.strength = 12
			subject.attack(opponent, attack_dice).should be_true

		end

		it "applies modifier to damage delt" do
			opponent = Evercraft::Character.new
			
			attack_dice = 9

			subject.strength = 12
			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 3
		end

		it "applies modifier to critical hits" do
			opponent = Evercraft::Character.new
			
			attack_dice = 20

			subject.strength = 12
			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 1
		end

		it "minimum damage is 1" do
			opponent = Evercraft::Character.new
			
			attack_dice = 19

			subject.strength = 1
			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 4
		end

		it "a miss does no damage" do
			opponent = Evercraft::Character.new
			
			attack_dice = 10

			subject.strength = 1
			subject.attack(opponent, attack_dice)

			opponent.hit_points.should eql 5
		end

	end
end
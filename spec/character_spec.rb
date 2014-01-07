require 'helper'

describe Evercraft::Character do
  
  it "has a name" do
  	subject.name = "ted"
    subject.name.should eql "ted"
  end


  it "if name is not set, it should be named 'unknown'" do
  	subject.name.should eql "unknown"
  end

  context "alignment" do

	  it "has an alignment" do
	  	subject.alignment.should eql :neutral
	  end

	  it "alignment can be set and read" do
	  	subject.alignment = :good
	  	subject.alignment.should eql :good
		end

		it "alignment set to invalid value throws exception" do
			expect { subject.alignment = :invalid }.to raise_error
		end

	end

	context "armor class and hit points" do
		it "has an armor class" do
			subject.armor_class = 15
			subject.armor_class.should eql 15
		end

		it "armor class defaults to 10" do
			subject.armor_class.should eql 10
		end	

		it "has hit points" do
			subject.hit_points = 100
			subject.hit_points.should eql 100
		end	

		it "has hit points defaulted to 5" do
			subject.hit_points.should eql 5
		end

		it "hit points is modified by constitution" do
			subject.constitution = 15
			subject.hit_points.should eql 7
		end

		it "hit points modifier not drop hit points below 1" do
			subject.constitution = 1
			subject.hit_points.should eql 1
		end

		it "adds hit points based on level and con modifier" do
			subject.constitution = 12
			subject.add_experience(1000)
			
			subject.hit_points.should eql 12
		end

	end


	context "Experience Points" do
		it "gains experience for a successful attack" do
			opponent = Evercraft::Character.new
			attack_dice = 15

			subject.attack(opponent, attack_dice)

			subject.experience.should eql 10 
		end

		it "doesn't gain anything if an attack misses" do
			opponent = Evercraft::Character.new
			attack_dice = 1

			subject.attack(opponent, attack_dice)

			subject.experience.should eql 0 
		end
	end

	context "Level" do
		it "has a level indicator that defaults to 1" do
			subject.level.should eql 1
		end

		it "level is based on experience" do
			subject.add_experience(1000)
			subject.level.should eql 2

			subject.add_experience(1000)
			subject.level.should eql 3

			subject.add_experience(500)
			subject.level.should eql 3
		end

		it "attack_modifier defaults to zero" do
			subject.attack_modifier.should eql 0
		end

		it "adds one to attack roll for even level" do
			subject.add_experience(1000)
			subject.level.should eql 2
			subject.attack_modifier.should eql 1
		end

		it "does not add to attack modifier for odd levels" do
			subject.add_experience(2000)
			subject.level.should eql 3
			subject.attack_modifier.should eql 1
		end
	end


end
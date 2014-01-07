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

		it "armor class is modified by dexterity" do
			subject.dexterity = 20
			subject.armor_class.should eql 15
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

	end





end
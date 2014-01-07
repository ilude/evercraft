require 'helper'

describe Evercraft::Fighter do
	it "gains 2 to attack_modifier on level 3" do
		subject.add_experience(2000)
		subject.level.should eql 3
		subject.attack_modifier.should eql 2
	end

	it "gains 10 hit points per level instead of 5" do
		subject.add_experience(2000)
		subject.level.should eql 3
		subject.hit_points.should eql 30
	end
end
require 'helper'

describe Evercraft::Character, "Abilities" do
	it "has abilities: strength, dexterity, constitiution, wisdom, intelligence, charisma" do
		subject.strength.should eql 10
		subject.dexterity.should eql 10
		subject.constitution.should eql 10
		subject.wisdom.should eql 10
		subject.intelligence.should eql 10
		subject.charisma.should eql 10
	end

	it "abilities should range between 1 and 20" do
		[:strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma].each do |ability|
			expect { subject.send("#{ability}=".to_sym, 0) }.to raise_error(Evercraft::InvalidArgument)
			expect { subject.send("#{ability}=".to_sym, 21) }.to raise_error(Evercraft::InvalidArgument)
		end
	end

	it "creates modifiers from the ability scores" do
		[-5, -4, -4, -3, -3, -2, -2, -1, -1, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5].each_with_index do |modifier, idx|
			subject.strength = idx + 1
			subject.modifier(:strength).should eql modifier
		end
	end

	

end
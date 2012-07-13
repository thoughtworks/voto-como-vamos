require 'spec_helper'

describe Opinion do
  it { should validate_presence_of :user }
  it { should validate_presence_of :proposal }

  [Opinion::AGREE, Opinion::DISAGREE].each do |value|
    it { should allow_value(value).for(:value) }
  end

  it { should_not allow_value(2).for(:value) }

  it { 
    FactoryGirl.create :opinion
    should validate_uniqueness_of(:user_id).scoped_to(:proposal_id)
  }


  it "should filter by agreements" do
    Opinion.agreements.should be_empty

    FactoryGirl.create :opinion, value: Opinion::AGREE
    Opinion.agreements.should_not be_empty
  end

  it "should filter by agreements" do
    Opinion.disagreements.should be_empty

    FactoryGirl.create :opinion, value: Opinion::DISAGREE
    Opinion.disagreements.should_not be_empty
  end

  context "#agree?" do

    it "should agree" do
      opinion = Opinion.new value: Opinion::AGREE
      opinion.agree?.should be_true
      opinion.disagree?.should be_false
    end

    it "should disagree when disagreed" do
      opinion = Opinion.new value: Opinion::DISAGREE
      opinion.agree?.should be_false
      opinion.disagree?.should be_true
    end

  end
end

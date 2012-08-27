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
    proposal = FactoryGirl.create :proposal
    Opinion.agreements(proposal).should be_empty

    FactoryGirl.create :opinion, value: Opinion::AGREE, proposal: proposal
    Opinion.agreements(proposal).should have(1).item

    FactoryGirl.create :opinion, value: Opinion::AGREE
    Opinion.agreements(proposal).should have(1).item
  end

  it "should filter by agreements" do
    proposal = FactoryGirl.create :proposal
    Opinion.disagreements(proposal).should be_empty

    FactoryGirl.create :opinion, value: Opinion::DISAGREE, proposal: proposal
    Opinion.disagreements(proposal).should have(1).item

    FactoryGirl.create :opinion, value: Opinion::DISAGREE
    Opinion.disagreements(proposal).should have(1).item
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

  it "filter opinions that were updated in the last week" do
    old_opinion = FactoryGirl.create :opinion, updated_at: 10.days.ago
    new_opinion = FactoryGirl.create :opinion, updated_at: 2.days.ago

    described_class.last_week.should have_exactly(1).items
    described_class.last_week.should include(new_opinion)
  end
end

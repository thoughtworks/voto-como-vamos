# encoding: utf-8
require 'spec_helper'

describe Proposal do
  it { should have_and_belong_to_many(:categories) }

  it { should belong_to(:candidate) }
  it { should validate_presence_of(:candidate) }

  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(100) }

  it { should validate_presence_of(:abstract) }
  it { should ensure_length_of(:abstract).is_at_most(300) }

  it { should have_many(:opinions) }

  it { should validate_presence_of(:description) }

  it 'can be found by text criteria and filtered by categories' do
    category = FactoryGirl.create :category
    proposal = FactoryGirl.create :proposal, :title => 'Test', :categories => [category]
    results = Proposal.search_in_categories('Test', [category.id])
    results.should include(proposal)
  end

  it 'should not include another categories than specified in search' do
    another_category = FactoryGirl.create :category
    proposal = FactoryGirl.create :proposal, :title => 'Test'
    results = Proposal.search_in_categories('Test', [another_category.id])
    results.should_not include(proposal)
  end

  it "should order the proposals by votes" do
    proposal_with_more_votes = FactoryGirl.create :proposal
    proposal_with_less_votes = FactoryGirl.create :proposal

    give_votes_to_proposal(proposal_with_less_votes, 2)
    give_votes_to_proposal(proposal_with_more_votes, 5)

    expected = [proposal_with_more_votes, proposal_with_less_votes]
    Proposal.ordered_by_votes.to_a.should be == expected

  end

  it "should order the proposals by opinions that happened last week" do
    very_old_proposal = FactoryGirl.create :proposal
    old_proposal = FactoryGirl.create :proposal
    not_so_new_proposal = FactoryGirl.create :proposal
    new_proposal = FactoryGirl.create :proposal

    3.times { FactoryGirl.create :opinion, proposal: very_old_proposal, updated_at: 10.days.ago }

    5.times { FactoryGirl.create :opinion, proposal: old_proposal, updated_at: 10.days.ago }
    2.times { FactoryGirl.create :opinion, proposal: old_proposal, updated_at: Date.today }

    3.times { FactoryGirl.create :opinion, proposal: not_so_new_proposal, updated_at: 2.days.ago}

    4.times { FactoryGirl.create :opinion, proposal: new_proposal, updated_at: Date.today }

    10.times do
      p = FactoryGirl.create :proposal
      FactoryGirl.create :opinion, proposal: p, updated_at: Date.today
    end

    ordered = described_class.ordered_by_votes_in_the_last_week

    ordered.should have_exactly(10).items
    ordered[0].should == new_proposal
    ordered[1].should == not_so_new_proposal
    ordered[2].should == old_proposal
    ordered.should_not include(very_old_proposal)
  end

  it "should order the proposals by creation date" do
    10.times { FactoryGirl.create :proposal, created_at: 10.days.ago }
    very_old_proposal = FactoryGirl.create :proposal, created_at: 4.days.ago
    old_proposal = FactoryGirl.create :proposal, created_at: 2.days.ago
    new_proposal = FactoryGirl.create :proposal, created_at: Date.today

    ordered = described_class.ordered_by_creation_date

    ordered[0].should == new_proposal
    ordered[1].should == old_proposal
    ordered[2].should == very_old_proposal
    ordered.should have_exactly(5).items
  end

end

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

  it { should validate_presence_of(:description) }

  it 'can be found by text criteria and filtered by categories' do
    category = FactoryGirl.create :category
    proposal = FactoryGirl.create :proposal, :title => 'Test', :categories => [category]
    Sunspot.commit
    results = Proposal.search_in_categories('Test', [category.id])
    results.should include(proposal)
  end

  it 'should not include another categories than specified in search' do
    another_category = FactoryGirl.create :category
    proposal = FactoryGirl.create :proposal, :title => 'Test'
    Sunspot.commit
    results = Proposal.search_in_categories('Test', [another_category.id])
    results.should_not include(proposal)
  end
end

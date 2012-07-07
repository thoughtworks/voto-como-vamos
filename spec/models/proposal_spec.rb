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

  let(:search_engine) { double('Search Engine Wrapper') }

  it 'can be found by text criteria' do
    search_engine.should_receive(:search).with('test', :load => true)

    Proposal.stub!(:tire).and_return(search_engine)
    Proposal.search('test')
  end

  it 'can be found by text criteria and filtered by categories' do
    search_engine.should_receive(:search).with(nil, :load => true).and_yield
    Proposal.should_receive(:filter).with(:terms, :categories => ['category'])

    Proposal.stub!(:tire).and_return(search_engine)
    Proposal.search(nil, 'category')
  end

  it 'indexes categories together with proposal' do
    categories = [
      mock_model(Category, :name => 'category1'), 
      mock_model(Category, :name => 'category2')
    ]
    proposal = Proposal.new(
      :title => 'Title',
      :abstract => 'Abstract',
      :description => 'Description',
      :categories => categories
    )
    proposal.to_indexed_json.should == {
      :title => 'Title',
      :abstract => 'Abstract',
      :description => 'Description',
      :categories => ['category1', 'category2']
    }.to_json
  end
end

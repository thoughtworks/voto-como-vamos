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

end

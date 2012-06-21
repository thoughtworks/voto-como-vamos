require 'spec_helper'

describe Candidate do

  it { should have_many(:proposals) }

  it { should validate_presence_of :name }

end

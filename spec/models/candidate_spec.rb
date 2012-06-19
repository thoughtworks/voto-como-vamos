require 'spec_helper'

describe Candidate do
  it { should validate_presence_of :name }
end

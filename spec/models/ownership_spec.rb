require 'spec_helper'

describe Ownership do
  it { should belong_to :user }
  it { should belong_to :candidate }
  it { should validate_acceptance_of :terms_and_conditions }
end

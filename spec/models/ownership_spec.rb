require 'spec_helper'

describe Ownership do
  it { should belong_to :user }
  it { should belong_to :candidate }
  it { should validate_acceptance_of :terms_and_conditions }
  it { should validate_presence_of :user }
  it { should validate_presence_of :candidate }
end

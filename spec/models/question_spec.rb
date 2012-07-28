require 'spec_helper'

describe Question do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:proposal) }
  it { should validate_presence_of(:description) }
end

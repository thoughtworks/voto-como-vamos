require 'spec_helper'

describe Revindication do
  it { should belong_to(:candidate) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:candidate) }
end

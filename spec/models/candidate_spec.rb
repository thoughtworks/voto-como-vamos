require 'spec_helper'

describe Candidate do

  it { should have_many(:proposals) }

  it { should validate_presence_of :name }
  
  it { should ensure_length_of(:about).is_at_most(500) }
  it { should ensure_length_of(:phone).is_equal_to(13) }
     
  it { should validate_presence_of :email }
  it { should validate_format_of(:email).with("valid@email.com") }
  it { should validate_format_of(:email).not_with("invalid.com") }
end

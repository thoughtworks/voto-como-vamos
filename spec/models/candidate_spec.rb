require 'spec_helper'

describe Candidate do
  context 'associations' do
    it { should have_many(:proposals) }
  end

  context 'validations ' do
    it { should validate_presence_of :name }

    it { should ensure_length_of(:about).is_at_most(500) }
    it { should ensure_length_of(:phone).is_equal_to(13) }
       
    it { should_not allow_value("blah").for(:site) }
    it { should allow_value("http://www.blah.com").for(:site) }

    it { should_not allow_value("blah").for(:blog) }
    it { should allow_value("http://www.blah.com").for(:blog) }

    it { should_not allow_value("bl{ah").for(:facebook) }
    it { should allow_value("http://www.blah.com").for(:facebook) }

    it { should_not allow_value("bl{ah").for(:twitter) }
    it { should allow_value("http://www.blah.com").for(:twitter) }
    
    it { should allow_value(nil).for(:press_agent) }  
    it { should allow_value(true).for(:press_agent) }
    it { should allow_value(false).for(:press_agent) }

    it { should validate_presence_of :email }
    it { should_not allow_value("blah").for(:email) }
    it { should allow_value("a@blah.com").for(:email) }
  end

  it 'should generate a unique slug for candidate' do
    Digest::SHA1.should_receive(:hexdigest).with('Test').and_return('obfuscated')
    candidate = Candidate.create!(:name => 'Test', :email => 'test@test.com')
    candidate.obfuscated_slug.should == 'obfuscated'
  end
end

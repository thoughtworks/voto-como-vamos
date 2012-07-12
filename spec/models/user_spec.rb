require 'spec_helper'

describe User do
  it { should validate_presence_of :name }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }

  it 'can be created via auth hash' do
    auth_hash = {
      'provider' => 'facebook',
      'uid' => '1234',
      'info' => {
      'name' => 'Test',
      'email' => 'test@test.com'
    }
    }

    expect { User.create_with_auth(auth_hash) }.to change(User, :count).by(1)

    created_user = User.last
    created_user.provider.should == 'facebook'
    created_user.uid.should == '1234'
    created_user.name.should == 'Test'
    created_user.email.should == 'test@test.com'
  end

  it 'can be found by provider and uid' do
    user = FactoryGirl.create :user, provider: 'facebook', uid: '1234'
    User.find_by_provider_and_uid('facebook', '1234').should == user
  end


  describe "Representation" do

    let(:user) { FactoryGirl.create :user }
    let(:candidate) { FactoryGirl.create :candidate } 

    it 'should check the ownership of a candidate' do
      Ownership.create! :user => user, :candidate => candidate

      user.represents?(candidate).should be_true
    end

    it 'should check the ownership of a candidate' do
      user.represents?(candidate).should be_false
    end
  end
end

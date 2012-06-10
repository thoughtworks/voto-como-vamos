FactoryGirl.define do
  factory :user do
    provider 'facebook'
    uid '1234'
    email 'test@test.com'
    name 'Test user'
  end
end


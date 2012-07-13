# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opinion do
    id 1
    user
    proposal
    value 1
  end
end

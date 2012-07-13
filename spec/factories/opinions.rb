# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :opinion do
    id 1
    user nil
    proposal nil
    agree false
  end
end

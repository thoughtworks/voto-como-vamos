# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    description "MyText"
    proposal nil
    user nil
    answer "MyText"
  end
end

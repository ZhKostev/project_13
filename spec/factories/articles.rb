# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title { Faker::Name.name }
    meta_description "MyString"
    short_description "MyString"
    body "MyText"
  end
end

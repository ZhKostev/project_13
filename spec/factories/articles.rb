# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    language 'ru'
    title { Faker::Name.name }
    meta_description "MyString"
    short_description "MyString"
    body "MyText"
    origin_id nil
  end
end

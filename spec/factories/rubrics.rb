# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rubric, :class => 'Rubric' do
    language "ru"
    title { Faker::Name.name }
  end
end

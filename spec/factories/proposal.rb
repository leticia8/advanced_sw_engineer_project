FactoryBot.define do
    factory :proposal do
      name { Faker::Name.name }
      description { Faker::Name.name }
      election
    end
  end
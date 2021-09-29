FactoryBot.define do
    factory :option do
      description { Faker::Name.name }
      proposal
    end
  end
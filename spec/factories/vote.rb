FactoryBot.define do
    factory :vote do
      vote_date { Faker::Time.backward(days: 1, period: :morning) }
      option
    end
  end
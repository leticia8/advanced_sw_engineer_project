FactoryBot.define do
  factory :election do
    description { Faker::Name.name }
    start_date { Faker::Time.between_dates(from: Date.today + 1, to: Date.today + 2, period: :morning) }
    finish_date { Faker::Time.between_dates(from: Date.today + 3, to: Date.today + 4, period: :morning) }
    user
    segmented_by { :city }
    condition { 'Montevideo' }
    activated { true }
  end
end
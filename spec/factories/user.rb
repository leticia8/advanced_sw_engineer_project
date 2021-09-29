FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      country { 'Uruguay' }
      city { 'Montevideo' }
      state { 'Montevideo' }
      birth_date { '1997-03-13' }
      password { Faker::Internet.password }
      confirmed_at  { '2020-10-07 00:38:31.906089' }
      admin { true }
    end
  end
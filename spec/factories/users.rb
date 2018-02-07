FactoryBot.define do
    factory :user do
      sequence(:email) { |n| "test#{n}@test.com" }
      password "12345678"
    end
  end
  
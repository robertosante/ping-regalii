FactoryBot.define do
    factory :game do
      association :user, factory: :user
      association :challenger, factory: :user
      user_score 21
      challenger_score 19
      game_date "2018-02-07"
    end
  end
  
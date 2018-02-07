require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { FactoryBot.create(:game) }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:challenger) }
  end

  describe 'validations' do
     it { should  validate_presence_of(:user) }
     it { should  validate_presence_of(:challenger) }
     it { should  validate_presence_of(:user_score) }
     it { should  validate_presence_of(:challenger_score) }
     it { should  validate_presence_of(:game_date) }
     it { is_expected.to callback(:set_difference).before(:validation) }
  end

  it 'should not be valid with a score of less than 21' do
    game.user_score = 20
    game.challenger_score = 19
    game.valid?
    expect(game.errors[:base]).to include('Not valid winning score')
  end

  it 'should not be valid with a difference of more than 2' do
    game.user_score = 25
    game.challenger_score = 19
    game.valid?
    expect(game.errors[:base]).to include('Too much difference in points')
  end

  it 'should be valid with a score of more than 21' do
    game.user_score = 21
    game.challenger_score = 19
    expect(game).to be_valid
  end

  it 'should validate winer' do
    game.user_score = 21
    game.challenger_score = 19
    expect(game.winner).to eq(game.user)
  end
  
end

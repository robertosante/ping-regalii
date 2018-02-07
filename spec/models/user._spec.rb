require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'Associations' do
    it { should have_many(:games) }
  end
  
  describe 'validations' do
    it { should  validate_presence_of(:email) }
    it { should  validate_presence_of(:password) }

    it 'is not valid with nulls' do
      user.email = nil
      user.password = nil
      expect(user).to_not be_valid
    end
  end

  describe '#games?' do
    it 'return user games' do
      games = FactoryBot.create_pair(:game, user: user)
      expect(user.games).to eq(games)
    end
  end

end

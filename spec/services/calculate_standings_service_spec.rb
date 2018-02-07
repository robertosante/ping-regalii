require 'rails_helper'

describe CalculateStandingsService, type: :model do
  let(:user) { FactoryBot.create(:user, rating: 0 ) }
  let(:challenger) { FactoryBot.create(:user, rating: 0) }
  
  it 'updates the user ratings' do
    rating = CalculateStandingsService.new(user, challenger, user)
    expect(rating.proceed).to have_attributes({ user: 20, challenger: -20 })
  end

end

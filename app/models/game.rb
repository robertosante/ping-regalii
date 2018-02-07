class Game < ActiveRecord::Base
    belongs_to :user
    belongs_to :challenger, class_name: 'User'

    validates_presence_of  :user, :challenger, :user_score, :challenger_score, :game_date
    
    validates_numericality_of :user_score, :challenger_score, only_integer: true, greater_than_or_equal: 0

    validate :valid_score 

    before_validation :set_difference

    after_create :update_ratings!

    MIN_POINTS_ALLOWED = 21

    def set_difference
        self.difference = (user_score - challenger_score).abs if user_score && challenger_score
    end

    def winner
        user_score > challenger_score ? user : challenger
    end

    private
        def valid_score
            if user_score && challenger_score 
                errors.add(:base, "Not valid winning score") if user_score < MIN_POINTS_ALLOWED && challenger_score < MIN_POINTS_ALLOWED
                if user_score >= MIN_POINTS_ALLOWED || challenger_score >= MIN_POINTS_ALLOWED
                    if user_score > MIN_POINTS_ALLOWED || challenger_score > MIN_POINTS_ALLOWED
                        errors.add(:base, "Too much difference in points") if self.difference > 2
                    end
                    return true if user_score < challenger_score || user_score > challenger_score
                end
            end
            return false
        end

        def update_ratings!
            updated_rating = CalculateStandingsService.new(user, challenger, winner).proceed 
            user.update(rating: updated_rating[:user])
            challenger.update(rating: updated_rating[:challenger])
        end
end
class Game < ActiveRecord::Base
    belongs_to :user
    belongs_to :challenger, class_name: 'User'

    validates_presence_of  :user, :challenger, :user_score, :challenger_score, :game_date
    
    validates_numericality_of :user_score, :challenger_score, only_integer: true, greater_than_or_equal: 0

    validate :valid_score 

    after_initialize :set_difference

    MIN_POINTS_ALLOWED = 21

    def set_difference
        self.difference ||= (user_score - challenger_score).round
    end

    def winner
        user_score > challenger_score ? user : challenger
    end

    def valid_score
        if user_score && challenger_score 
            if user_score >= MIN_POINTS_ALLOWED || challenger_score >= MIN_POINTS_ALLOWED
                return false if self.difference <= 2
                return true if user_score < challenger_score || user_score > challenger_score
            end
            
            errors.add(:base, "Not valid winning score") if user_score < MIN_POINTS_ALLOWED && challenger_score < MIN_POINTS_ALLOWED
            
            return false
        end
    end
end

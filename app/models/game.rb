class Game < ActiveRecord::Base
    belongs_to :user
    belongs_to :challenger, class_name: 'User'

    validates_presence_of  :user, :challenger, :user_score, :challenger_score, :round_date
    validates_numericality_of :user_score, :challenger_score, only_integer: true, greater_than_or_equal: 0
end

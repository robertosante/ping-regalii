class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :games

  scope :challengers, ->(user) { where("id != ?", user) }
  scope :rankings, -> () { order("rating DESC") }

  def user_challengers
    User.challengers(id)
  end

  def user_games
    Game.where("user_id = ? OR challenger_id = ?", self.id,  self.id)
  end
end

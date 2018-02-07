class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :rounds

  scope :challengers, ->(user) { where("id != ?", user) }
end

class HomeController < ApplicationController
  def index
    @users = User.rankings
  end
end

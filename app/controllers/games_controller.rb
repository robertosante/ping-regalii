class GamesController < ApplicationController

  def index
    @games = current_user.games
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
      redirect_to games_path, notice: 'Game was successfully created.'
    else
      render :new
    end
  end
  private
  
    def game_params
      params.require(:game).permit(:user_id, :challenger_id, :user_score, :challenger_score, :game_date)
    end
end

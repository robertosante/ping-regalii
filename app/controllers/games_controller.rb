class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end
  private
  
    def game_params
      params.require(:game).permit(:user_id, :challenger_id, :user_score, :challenger_score, :game_date)
    end
end

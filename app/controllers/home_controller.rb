class HomeController < ApplicationController
  require 'game'
  rescue_from Game::IllegalMoveError do |exception|
    redirect_to root_path, :alert => exception.message
  end
  $game = Game.new

  def main
    @out = $game.stores
    @player = $game.current_player
    @winner = $game.has_current_player_won
  end

  def temp
    my_input = params[:my_input].to_i
    $game.sow(my_input)
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Move Applied." }
    end
  end

  def reset
    $game=Game.new
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Game Reset Completed." }
    end
  end
end

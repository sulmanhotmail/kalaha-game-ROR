class HomeController < ApplicationController
  require 'game'
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
      format.html { redirect_to root_path, notice: "redirected" }
    end
  end

  def reset
    $game=Game.new
    respond_to do |format|
      format.html { redirect_to root_path, notice: "redirected" }
    end
  end
end

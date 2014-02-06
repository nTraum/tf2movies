class GameModesController < ApplicationController
  def index
  end

  def moderate
    @game_modes = GameMode.all
  end

  def new
    @game_mode = GameMode.new
  end

  def create
    @game_mode = GameMode.new(game_mode_params)

    if @game_mode.save
      redirect_to moderate_game_modes_path, :notice => "Game Mode '#{@game_mode.name}' has been created successfully!"
    else
      redirect_to new_game_mode_path, :alert => @game_mode.errors.full_messages.join(', ')
    end
  end

  def show
  end

  def edit
    @game_mode = GameMode.find(params[:id])
  end

  def update
    @game_mode = GameMode.find(params[:id])

    if @game_mode.update(game_mode_params)
      redirect_to moderate_game_modes_path, :notice => 'Game Mode updated.'
    else
      redirect_to moderate_game_modes_path, :alert => @game_mode.errors.full_messages.join(', ')
    end
  end

  def destroy
    @game_mode = GameMode.find(params[:id]).destroy
    redirect_to moderate_game_modes_path, :notice => 'Game Mode deleted.'
  end

  private

  def game_mode_params
    params.require(:game_mode).permit(:name)
  end
end

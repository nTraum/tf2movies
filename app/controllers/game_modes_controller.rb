class GameModesController < ApplicationController
  after_action :verify_authorized, :except => [:index, :show]

  def index
  end

  def manage
    @game_modes = GameMode.all.page params[:page]
    authorize @game_modes
  end

  def new
    @game_mode = GameMode.new
    authorize @game_mode
  end

  def create
    @game_mode = GameMode.new(game_mode_params)
    authorize @game_mode
    if @game_mode.save
      redirect_to manage_game_modes_path, :notice => "Game Mode '#{@game_mode.name}' has been created successfully!"
    else
      redirect_to new_game_mode_path, :alert => @game_mode.errors.full_messages.join(', ')
    end
  end

  def show
  end

  def edit
    @game_mode = GameMode.find(params[:id])
    authorize @game_mode
  end

  def update
    @game_mode = GameMode.find(params[:id])
    authorize @game_mode

    if @game_mode.update(game_mode_params)
      redirect_to manage_game_modes_path, :notice => 'Game Mode updated.'
    else
      redirect_to manage_game_modes_path, :alert => @game_mode.errors.full_messages.join(', ')
    end
  end

  def destroy
    @game_mode = GameMode.find(params[:id])
    authorize @game_mode
    @game_mode.destroy
    redirect_to manage_game_modes_path, :notice => 'Game Mode deleted.'
  end

  private

  def game_mode_params
    params.require(:game_mode).permit(:name)
  end
end

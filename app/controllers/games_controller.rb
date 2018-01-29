class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @games = Game.all
  end

  def show
    @developers = @game.developers
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:success] = "#{@game.name}, #{t(:welcome)} #{I18n.t(:to)} Gamarch!"
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      flash[:success] = I18n.t(:developer_updated)
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    @game.destroy
    flash[:danger] = I18n.t(:developer_deleted)
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :description, :release, :website, developer_ids: [])
  end

  def set_game
    @game = Game.find(params[:id])
  end
end

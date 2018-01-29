class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, only: [:destroy]

  def index
    @communities = Community.all
  end

  def show
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.user = current_user
    if @community.save
      flash[:success] = "#{@community.name}, #{t(:welcome)} #{I18n.t(:to)} Gamarch!"
      redirect_to community_path(@community)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @community.update(community_params)
      flash[:success] = I18n.t(:community_updated)
      redirect_to @community
    else
      render 'edit'
    end
  end

  def destroy
    @community.destroy
    flash[:danger] = I18n.t(:community_deleted)
    redirect_to games_path
  end

  private

  def community_params
    params.require(:community).permit(:name, :description, :website, :game_id)
  end

  def set_community
    @community = Community.find(params[:id])
  end

  def require_same_user
    if current_user != @community.user && !current_user.admin?
      redirect_to page404_path
    end
  end
end

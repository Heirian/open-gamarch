class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @developers = Developer.all
  end

  def show
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)
    if @developer.save
      flash[:success] = "#{@developer.name}, #{t(:welcome)} #{I18n.t(:to)} Gamarch!"
      redirect_to developer_path(@developer)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @developer.update(developer_params)
      flash[:success] = I18n.t(:developer_updated)
      redirect_to @developer
    else
      render 'edit'
    end
  end

  def destroy
    @developer.destroy
    flash[:danger] = I18n.t(:developer_deleted)
    redirect_to users_path
  end

  private

  def developer_params
    params.require(:developer).permit(:name, :description, :headquarters, :founded, :website)
  end

  def set_developer
    @developer = Developer.find(params[:id])
  end

  def require_admin
    redirect_to page404_path unless current_user.admin?
  end
end

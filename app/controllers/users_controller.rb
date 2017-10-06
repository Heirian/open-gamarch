class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :pass]
  before_action :require_user, except: [:new, :create, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy, :pass]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 8)
  end

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if @user.gender == 'girl'
        u_welcome = I18n.t(:welcome_f)
      else
        u_welcome = I18n.t(:welcome)
      end
      session[:user_id] = @user.id
      cookies.signed[:user_id] = @user.id
      flash[:success] = "#{@user.name}, #{u_welcome} #{I18n.t(:to)} Gamarch!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = I18n.t(:your_account_updated)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if !@user.admin?
      @user.destroy
      flash[:danger] = I18n.t(:user_deleted)
      redirect_to users_path
    end
  end

  def following
    @title = I18n.t(:following)
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = I18n.t(:followers)
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def pass
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :gender, :birthday, :avatar, :remove_avatar, :image, :remove_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    redirect_to page404_path if current_user != @user && !current_user.admin?
  end

end

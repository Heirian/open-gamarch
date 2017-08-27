class SessionsController < ApplicationController
  before_action :require_no_user, only: [:create]

  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      cookies.signed[:user_id] = user.id
      flash[:success] = "You have successfully logged in!"
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "You have successfully logged out!"
    redirect_to root_path
  end

  private

  def require_no_user
    if logged_in?
      flash[:danger] = "You must log out to log in with another user!"
      redirect_to root_path
    end
  end

end

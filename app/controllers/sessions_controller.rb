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
      if user.gender == 'girl'
        u_welcome = I18n.t(:Welcome_back_f)
      else
        u_welcome = I18n.t(:Welcome_back)
      end
      flash[:success] = "#{u_welcome}, #{current_user.name}. #{I18n.t(:log_in_success)}"
      back_to_location
    else
      flash[:danger] = I18n.t(:invalid_login)
      back_to_location
    end
  end

  def destroy
    log_out
    flash[:success] = I18n.t(:log_out_success)
    redirect_to root_path
  end

  private

  def require_no_user
    if logged_in?
      flash[:danger] = I18n.t(:log_out_to_login)
      back_to_location
    end
  end

  def back_to_location
    redirect_back(fallback_location: root_path)
  end

end

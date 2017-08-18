class PagesController < ApplicationController
  def home
    redirect_to signup_path unless logged_in?
  end

  def about
  end

  def help
  end

  def contact
  end

  def privacy
  end

  def terms
  end

  def starting
  end

end

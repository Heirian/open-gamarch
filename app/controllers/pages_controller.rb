class PagesController < ApplicationController
  def home
    unless logged_in?
      redirect_to signup_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
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

  def policy_cookie
  end
end

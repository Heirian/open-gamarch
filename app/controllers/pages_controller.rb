class PagesController < ApplicationController
  def home
    if logged_in?
      @article = Article.new
      @comment = Comment.new
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 8)
    else
      @user = User.new
    end
  end

  def about
    render layout: false
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

  def page404
  end
end

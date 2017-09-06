class PagesController < ApplicationController
  def home
    unless logged_in?
      redirect_to signup_path
    else
      @article = Article.new
      @comment = Comment.new
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 8)
      respond_to do |format|
        format.html
        format.js
      end
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

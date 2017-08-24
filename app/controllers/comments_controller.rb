class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :require_attributed_user]
  before_action :require_user
  before_action :require_attributed_user, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
    else
      flash[:danger] = "Comment wasn't created"
      redirect_back(fallback_location: article_path(@article))
    end
  end

  def destroy
    @comment.destroy
    flash[:danger] = "Comment removed"
    redirect_back(fallback_location: article_path(@article))
  end

  private

  def comments_params
    params.require(:comment).permit(:description)
  end

  def require_attributed_user
    unless (current_user.admin? || current_user == @comment.user || current_user == @article.user)
      flash[:danger] = "You can't do that"
      redirect_back(fallback_location: article_path(@article))
    end
  end

  def set_comment
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end
end

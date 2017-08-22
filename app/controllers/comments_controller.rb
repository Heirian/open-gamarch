class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :require_attributed_user]
  before_action :require_user
  before_action :require_attributed_user, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment was created successfully!"
      redirect_to article_path(@article)
    else
      flash[:danger] = "Comment wasn't created"
      redirect_back(fallback_location: article_path(@article))
    end
  end

  def destroy

    @comment.destroy
    flash[:success] = "Comment was removed successfully!"
    redirect_back(fallback_location: article_path(@article))
  end

  private

  def comments_params
    params.require(:comment).permit(:description)
  end

  def require_attributed_user
    unless (current_user.admin? || current_user == @comment.user || current_user == @article.user)
      flash[:danger] = "You can only change your own things"
      redirect_back(fallback_location: article_path(@article))
    end
  end

  def set_comment
    @article = Article.find(params[:id])
    @comment = Comment.find(params[:article_id])
  end
end

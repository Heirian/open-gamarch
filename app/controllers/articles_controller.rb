class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit,:update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 8)
  end

  def show
    @comment = Comment.new
    @comments = @article.comments.paginate(page: params[:page], per_page: 10)
    @user = @article.user
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was created successfully!"
      redirect_to @article
    else
      @feed_items = []
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully!"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:success] = "Article was deleted successfully!"
    redirect_to articles_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:name, :description, :image)
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:danger] = "You can only change your own things"
        redirect_to articles_path
      end
    end
end

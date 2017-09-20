class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit,:update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin_user, except: [:index, :show]

  def index
    if params[:locale] == 'pt'
      @user = User.find(4)
      @posts = @user.posts.paginate(page: params[:page], per_page: 6)
      @random_posts = @user.posts.where(id: @user.posts.pluck(:id).sample(3))
    else
      @user = User.find(3)
      @posts = @user.posts.paginate(page: params[:page], per_page: 6)
      @random_posts = @user.posts.where(id: @user.posts.pluck(:id).sample(3))
    end
  end

  def show
    @user = @post.user
    @posts = @user.posts.reject { |r| r.id == @post.id }
    @random_posts = @posts.sample(3)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "Post was created successfully!"
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was updated successfully!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post was deleted successfully!"
    redirect_to posts_path
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :description, :image, :file, :remove_image)
    end

    def require_same_user
      if current_user != @post.user && !current_user.admin?
        flash[:danger] = "You can only change your own things"
        redirect_back(fallback_location: root_path)
      end
    end

    def require_admin_user
      if !current_user.admin?
        redirect_back(fallback_location: root_path)
      end
    end
end

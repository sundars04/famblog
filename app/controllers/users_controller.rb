class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, :only => [:edit, :update]
  before_action :require_same_user, :only => [:edit, :update]
  
  def index
    @users = User.reorder("created_at DESC").page(params[:page]).per_page(10)
    @articles = Article.reorder("created_at DESC").page(params[:page]).per_page(10)
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new  
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome To Blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit    
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Account details updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user
        flash[:danger] = "You can only edit your account"
        redirect_to users_path
      end
    end
end
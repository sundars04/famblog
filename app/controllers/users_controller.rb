class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, :only => [:edit, :update]
  before_action :require_same_user, :only => [:edit, :update, :destroy]
  before_action :require_admin, :only => [:destroy]
  
  def index
    @users = User.reorder("created_at DESC").page(params[:page]).per_page(10)
    @articles = Article.reorder("created_at DESC").page(params[:page]).per_page(10)
  end

  def show
    @user_articles = @user.articles.reorder("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new  
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome To Blog #{@user.username}"
      redirect_to user_path(@user)
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

  def destroy
    @user.destroy
    flash[:danger] = "User and all articles created by User deleted"
    redirect_to users_path
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit your account"
        redirect_to users_path
      end
    end

    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only Admin users can perform that action"
        redirect_to root_path
      end
    end
end
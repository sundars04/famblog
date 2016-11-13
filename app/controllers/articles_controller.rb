class ArticlesController < ApplicationController
  before_action :find_article, :only => [:show, :edit, :update, :destroy]
  before_action :require_user, :except => [:index, :show]
  before_action :require_same_user, :only => [:edit, :update, :destroy]
  
  def index    
    @articles = Article.reorder("created_at DESC").page(params[:page]).per_page(5)
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)    
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "Article was updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
    flash[:danger] = "Article was deleted"
  end

  private

    def find_article
      @article = Article.find(params[:id])  
    end

    def article_params
      params.require(:article).permit(:title, :description, :user_id, :image)
    end

    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You can edit or delete only your article"
        redirect_to root_path
      end
    end

end
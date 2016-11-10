class ArticlesController < ApplicationController
  before_action :find_article, :only => [:show, :edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end

  def show    
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)    
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
      params.require(:article).permit(:title, :description, :user_id)
    end

end
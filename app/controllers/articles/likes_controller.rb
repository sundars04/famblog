class Articles::LikesController < ApplicationController
  before_action :require_user
  before_action :set_article

  def create
    @article.likes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def destroy
    @article.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  private

    def set_article
      @article = Article.find(params[:article_id])
    end
end
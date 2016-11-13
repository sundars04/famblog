class CategoriesController < ApplicationController
  def index
    @categories = Category.reorder("created_at DESC").page(params[:page]).per_page(5)
  end

  def show
    
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created successfully "
      redirect_to categories_path
    else
      render 'new'
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
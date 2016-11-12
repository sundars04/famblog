class CategoriesController < ApplicationController
  def index
    @categories = Category.order("created_at DESC")
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
class CategoriesController < ApplicationController
  before_action :find_catgory, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]
  def index
    @categories = Category.sorted.page(params[:page]).per_page(5)
  end

  def show    
    @category_articles = @category.articles.reorder("updated_at DESC").paginate(page: params[:page], per_page: 5)
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

  def edit    
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Category name was successfully updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end

  private

    def find_catgory
      @category = Category.find(params[:id])   
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = "Only admin can perform that action"
        redirect_to categories_path
      end
    end
end
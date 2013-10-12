class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_admin, :except => [:show]
  
  def new
    @category = Category.new
  end
  
  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end
  
  def create
    @category = Category.new(params[:category])
    @category.save ? (redirect_to categories_path, notice:"category is created successfully") 
                   : (redirect_to new_category_path, partial:"please enter category name")
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy ? (redirect_to categories_path, notice:"category remove") : flash[:partial] = "category is not remove"
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category]) ? (redirect_to categories_path, notice:"category updated")
                                                   : flash[:partial] = "category is not updated"
  end
  
end

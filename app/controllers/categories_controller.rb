class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  def new
    @category=Category.new
  end
  
  def index
    @categories = Category.all
  end
  def show
    
  end
  
  def create
    @category=Category.new(params[:category])
    if @category.save
      flash[:notice]="category is created successfully"  
      redirect_to welcome_users_path
    else
      flash[:partial]="please enter category name"
      redirect_to new_category_path  
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice]="category remove"    
      redirect_to categories_path
    else
      flash[:partial]="category is not remove"  
    end
  end
  
  def edit
    @category=Category.find(params[:id])  
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice]="category updated"
      redirect_to welcome_users_path
    else
      flash[:partial]="category is not updated"  
    end
  end
end

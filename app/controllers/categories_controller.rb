class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    if current_user.is_admin
      @category = Category.new
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end
  
  def create
    if current_user.is_admin
      @category = Category.new(params[:category])
      if @category.save
        flash[:notice] = "category is created successfully" 
        #TODO Redirect to index
        redirect_to categories_path
      else
        flash[:partial] = "please enter category name"
        redirect_to new_category_path  
      end
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
  def destroy
    if current_user.is_admin
      @category = Category.find(params[:id])
      if @category.destroy
        flash[:notice] = "category remove"  
        redirect_to categories_path
      else
        flash[:partial] = "category is not remove"  
      end
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
  def edit
    if current_user.is_admin
      @category = Category.find(params[:id])  
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
  
  def update
    if current_user.is_admin
      @category = Category.find(params[:id])
      if @category.update_attributes(params[:category])
        flash[:notice] = "category updated"
        #TODO Redirect to index
        redirect_to categories_path
      else
        flash[:partial] = "category is not updated"  
      end
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
end

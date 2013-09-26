class CategoriesController < ApplicationController
  
  def add
    @category=Category.new
  end
  
  def create
    @category=Category.new(params[:category])
    if @category.save
      redirect_to welcome_users_path
    end
  end
  
end

class ProductsController < ApplicationController

  def add
    @product=Product.new
    @category=Category.all
  end
  
  def create
    @product=Product.new(params[:product])
      if @product.save
        redirect_to welcome_users_path
      end
  end

end

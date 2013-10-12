class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_admin, :only => [:index, :new, :create, :destroy, :edit, :update]
  def new
    @product = Product.new 
  end
  
  def index
    @category = Category.all 
  end
  
  def create
    @product = Product.new(params[:product])
    @product.save ? flash[:notice]="product save" : flash[:partial]="please fill form correctly"
    redirect_to new_product_path
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def destroy
    @product = Product.find(params[:id])
    @cart = Cart.where(:product_id=>params[:id])
    @product.destroy and @cart.destroy_all ? (redirect_to products_path, notice:"product remove") 
                                           : flash[:partial]="product is not remove"
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product]) ? (redirect_to welcome_users_path, notice:"product updated") 
                                                 : flash[:partial]="product is not updated"  
  end
  
  def add_to_cart
    @cart = current_user.cart.where(:product_id=>params[:id]).first
    @pid = params[:id]
    if @cart.present?
      @message = "already present to cart"
    else
      @cart = current_user.cart.create(:product_id=>params[:id], :qty=>1)
      @message = "add to cart"
    end
  end
  
  def remove_from_cart
    @cart = current_user.cart.where(:product_id=>params[:id]).first.destroy
    @products = Product.find(params[:id])
  end
  
  def display_cart
    @cart = current_user.cart
  end
  
  def update_qty
    @cart = Cart.find(params[:id])
    @cart.update_attributes(:qty=>params[:qty])
  end
  
  def show_product_images
    @product = Product.find(params[:id])
  end
  
end

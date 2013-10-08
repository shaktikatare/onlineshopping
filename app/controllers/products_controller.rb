class ProductsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @product=Product.new
  end
  
  def index
    if current_user.is_admin
      @category = Category.all
    end
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice]="product save"    
      redirect_to new_product_path
    else
      flash[:partial]="please fill form correctly"
      redirect_to new_product_path
    end  
  end
  
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end
  
  def destroy
    @product = Product.find(params[:id])
    @cart=Cart.where(:product_id=>params[:id])
    if @product.destroy and @cart.destroy_all
      flash[:notice]="product remove"    
      redirect_to products_path
    else
      flash[:partial]="product is not remove"  
    end
  end
  
  def edit
    @product=Product.find(params[:id]) 
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice]="product updated"
      redirect_to welcome_users_path
    else
      flash[:partial]="product is not updated"  
    end
  end
  
  def product_details
    @product = Product.find(params[:id])
  end
  
  def add_to_cart
    @cart = Cart.where(:user_id=>current_user.id, :product_id=>params[:id]).first
    @pid = params[:id]
    if @cart.present?
      @message = "already present to cart"
    else 
      @cart = Cart.create(:user_id=>current_user.id, :product_id=>params[:id], :qty=>1)
      @message = "add to cart"
    end
    
  end
  
  def remove_from_cart
    @cart=Cart.where(:user_id => current_user.id, :product_id=>params[:id]).first.destroy
    @products=Product.find(params[:id])
    #redirect_to display_cart_products_path
  end
  
  def display_cart
    @cart = Cart.where(:user_id => current_user.id)
    @category_id=params[:id]
    @products=[]
    @cart.each do |c|
      @products << Product.find(c.product_id)
    end
  end
  
  def show_product_images
    @product=Product.find(params[:id])
  end
  
end

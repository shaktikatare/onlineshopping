class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :show_search_products]
  before_filter :authorize_admin, :except => [:show, :show_search_products, :add_to_cart, :update_qty, :display_cart, :remove_from_cart]
  
  def new
    @product = Product.new 
  end
  
  def create
    @product = Product.new(params[:product])
    @product.save ? flash[:notice]="product save" : flash[:partial]="please fill form correctly"
    redirect_to new_product_path
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def index
    @category = Category.all
    @available = params[:available] 
  end
  
  def show_product_by_category
    @category = Category.find(params[:id])
  end
  
  def show_search_products
    if params[:query].blank?
      redirect_to root_path, partial:"Please fill the form completly"
    else  
      @products = Product.where("name like ? and availability = true", "%#{params[:query]}%")
      redirect_to root_path, notice: "no record found" if @products.length == 0 
    end
  end
  
  def show_product_images
    @product = Product.find(params[:id])
  end
  
  def change_availability
    @product = Product.find(params[:id])
    @cart = Cart.where(:product_id=>params[:id])
    @product.availability ? @product.update_attributes(:availability => false) 
                          : @product.update_attributes(:availability => true)
    
    @cart.destroy_all
    flash[:notice] = "Change Availability successfully"
    @product.availability ? (redirect_to products_path(:availability => true))
                          : (redirect_to products_path(:availability => false))                                             
  end
  
    
  def remove_product_image
    @picture = Picture.find(params[:id])
    @picture.destroy ? (redirect_to products_path(:availability => true), notice:"image removed successfully") 
                     : (redirect_to products_path(:availability => true), partial:"image not removed successfully")                  
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
  
end

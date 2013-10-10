class ProductsController < ApplicationController
  before_filter :authenticate_user!
  def new
    if current_user.is_admin
      @product=Product.new
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
  
  def index
    if current_user.is_admin
      @category = Category.all
    end
  end
  
  def create
    if current_user.is_admin
      @product = Product.new(params[:product])
      if @product.save
        flash[:notice]="product save"
      else
        flash[:partial]="please fill form correctly"
      end
      redirect_to new_product_path
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
  def show
  end
  
  def destroy
    if current_user.is_admin
      @product = Product.find(params[:id])
      @cart=Cart.where(:product_id=>params[:id])
      if @product.destroy and @cart.destroy_all
        flash[:notice]="product remove"    
        redirect_to products_path
      else
        flash[:partial]="product is not remove"  
      end
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
  def edit
    if current_user.is_admin
      @product=Product.find(params[:id]) 
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
  def update
    if current_user.is_admin
      @product = Product.find(params[:id])
      if @product.update_attributes(params[:product])
        flash[:notice]="product updated"
        redirect_to welcome_users_path
      else
        flash[:partial]="product is not updated"  
      end
    else
      flash[:error] = "Access denied"
      redirect_to root_path
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
  end
  
  def display_cart
    @cart=current_user.cart
    @category_id=params[:id]
  end
  
  def update_qty
    @cart=Cart.find(params[:id])
    @cart.update_attributes(:qty=>params[:qty])
  end
  
  def show_product_images
    @product=Product.find(params[:id])
  end
  
end

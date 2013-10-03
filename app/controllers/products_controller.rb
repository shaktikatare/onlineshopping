class ProductsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @product=Product.new
  end
  
  def index
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to welcome_users_path
    end  
  end
  
  def show
    if current_user.is_admin
      @products = Product.all
    else
      @category = Category.find(params[:id])
      @products = @category.products
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
      flash[:notice]="product is not updated"  
    end
  end
  
  def product_details
    @product = Product.find(params[:id])
  end
  
  def addtocart
    @addtocart=Addtocart.where(:user_id=>current_user.id, :product_id=>params[:id]).first
    @pid=params[:id]
    if @addtocart.present?
      @message="already present to cart"
    else 
      @addtocart=Addtocart.new(:user_id=>current_user.id, :product_id=>params[:id])
      @addtocart.save
      @message="add to cart"
    end
  end
  
  def displaycart
    @cart = Addtocart.where(:user_id => current_user.id)
    @products=[]
    @cart.each do |c|
      @products << Product.find(c.product_id)
    end
  end
  
end

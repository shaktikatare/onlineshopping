class OrdersController < ApplicationController
  def new
    @order=Order.new
  end
  
  def create
    @order=Order.new(params[:order])
    @order.user_id=current_user.id
    @order.order_status = false
    if @order.save
      @cart = Cart.where(:user_id => current_user.id)
      @cart.each do |c|
        @orderdetails = Orderdetail.create(:order_id => @order.id, :product_id => c.product_id, :quantity => c.qty)
      end
      @cart.destroy_all  
      flash[:notice] = "order is placed successfully"
      redirect_to root_path
    else
      flash[:notice] = "order is not placed successfully"
      redirect_to root_path
    end
  end
  
  def index
    if current_user.is_admin?
      @order = Order.all
    else  
      @order = Order.where(:user_id => current_user.id)
    end  
  end
  
  def change_status
    @order=Order.find(params[:order_id])
    if @order.update_attributes(:order_status => params[:status])
      flash[:notice]="Status is updated successfully"
      redirect_to orders_path
    else
      flash[:notice]="Status is not updated successfully"
      redirect_to orders_path         
    end  
  end  
  
end

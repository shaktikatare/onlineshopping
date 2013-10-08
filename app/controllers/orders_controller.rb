class OrdersController < ApplicationController
  def new
    @order=Order.new
  end
  
  def create
    @order=Order.new(params[:order])
    @order.user_id=current_user.id
    @order.order_status = false
    if @order.save
      flash[:notice] = "order is created successfully"
      redirect_to root_path
    end
  end
 
end

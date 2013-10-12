class OrdersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :authorize_admin, :except => [:new, :index, :create]
  
  def new
    redirect_to root_path, partial:"no element in cart"  unless current_user.cart.present?
    @order = Order.new
  end
  
  def create
    @order = Order.new(params[:order])
    @order.user_id = current_user.id
    @order.order_status = false
    if @order.save
      current_user.cart.each do |c|
        @orderdetails = @order.orderdetails.create(:product_id => c.product_id, :quantity => c.qty)
      end
      AdminMailer.order_placed_email(current_user,@order)
      current_user.cart.destroy_all
      redirect_to root_path, notice:"order is placed successfully"
    else
      redirect_to new_order_path, partial:"order is not placed successfully"
    end
  end
  
  def destroy
    @order = Order.find(params[:id])
    redirect_to welcome_users_path, notice:"order is deleted successfully" if @order.destroy
  end
  
  def index
    @orders = current_user.is_admin? ? Order.all : current_user.orders
    @orders = paginate_items(@orders)
  end
  
  def search_form
  end
  
  def show_search_orders
    if params[:query].blank?
      redirect_to search_form_orders_path, partial:"Please fill the form completly"
    else 
      @orders = Order.where("id like ? OR full_name like ?", "%#{params[:query]}%", "%#{params[:query]}%")
      @orders = paginate_items(@orders)
      #flash[:partial] = "no record found" if @orders.length == 0
    end
  end
  
  def show_delivered_orders
    @orders = paginate_items(Order.delivered)
  end
  
  def show_undelivered_orders
    @orders = paginate_items(Order.un_delivered)
  end
  
  
  def change_status
    @order = Order.find(params[:order_id])
    @order.update_attributes(:order_status => params[:status]) ? flash[:notice]="Status is updated successfully" 
                                                               : flash[:notice]="Status is not updated successfully"
    redirect_to orders_path
  end
  
end

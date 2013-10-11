class OrdersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(params[:order])
    @order.user_id = current_user.id
    @order.order_status = false
    if @order.save
      AdminMailer.order_placed_email(current_user,@order)
      #TODO create Orderdetail with association of @order
      current_user.cart.each do |c|
        @orderdetails = Orderdetail.create(:order_id => @order.id, :product_id => c.product_id, :quantity => c.qty)
      end
      current_user.cart.destroy_all
      flash[:notice] = "order is placed successfully"
      redirect_to root_path
    else
      flash[:partial] = "order is not placed successfully"
      redirect_to new_order_path
    end
  end
  
  def index
    if current_user.is_admin?
      #TODO pluralize order
      @orders = Order.all
    else  
      @orders = current_user.orders #Order.where(:user_id => current_user.id)
    end  
  end
  
  def search_form
  end
  
  def show_search_orders
    if current_user.is_admin
      if params[:query] == ""
        flash[:partial] = "Please fill the form completly"
        redirect_to search_form_orders_path
      else  
        if params[:search]== "1"
          @orders = Order.where("id like ?", "%#{params[:query]}%")
          if @orders.length == 0
            #flash[:partial] = "no record found"
          end  
        end  
        if params[:search]== "2"
          @orders = Order.where("full_name like ?", "%#{params[:query]}%")    
          if @orders.length == 0
            #flash[:partial] = "no record found"
          end
        end
      end
    else 
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
  
  def show_delivered_orders
    if current_user.is_admin
      @orders= Order.delivered
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
  
  def show_undelivered_orders
    if current_user.is_admin
      @orders= Order.un_delivered
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
  
  
  def change_status
    if current_user.is_admin
      @order=Order.find(params[:order_id])
      if @order.update_attributes(:order_status => params[:status])
        flash[:notice]="Status is updated successfully"
      else
        flash[:notice]="Status is not updated successfully"
      end  
      redirect_to orders_path
    else
      flash[:error] = "Access denied"
      redirect_to root_path
    end  
  end
end

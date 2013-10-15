class UsersController < ApplicationController
  before_filter :authenticate_user!, :authorize_admin, :except => [:home]
  
  def home
  end
  
  def welcome
  end
  
  def index
    @users = User.where(:is_admin => false)
    @users = paginate_items(@users)
  end
  
  def destroy
    @user = User.find(params[:id])
    redirect_to users_path ,notice:"user is deleted successfully" if @user.destroy
  end
  
  def search_form
  end
  
  def show_search_users
    if params[:query].blank?
      redirect_to search_form_users_path, partial:"Please fill the form completly"
    else  
      @users = User.where("(email like ? OR first_name like ? OR last_name like ?) and is_admin=FALSE", 
                          "%#{params[:query]}%","%#{params[:query]}%","%#{params[:query]}%")
      @users = paginate_items(@users)
      #flash[:partial] = "no record found" if @users.length == 0
    end
  end
  
  def admin_email_form
  end
  
  def admin_send_email
    @users = User.where(:is_admin => false)
    @users.each do |user|
      AdminMailer.admin_email(user,params[:sub],params[:body])
    end
    redirect_to admin_email_form_users_path, notice:"emails are send successfully"
  end
  
end

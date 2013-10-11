class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:welcome]
  
  def home
  end
  
  def welcome
  end
  
  def index
    if current_user.is_admin
      @users = User.where(:is_admin => false)
    else
      flash[:error]="Access Denied"
      redirect_to root_path  
    end  
  end
  
  def destroy
    if current_user.is_admin
      @user= User.find(params[:id])
      @user.destroy
      redirect_to users_path ,notice:"user is deleted successfully"
    else
      flash[:error]="Access Denied"
      redirect_to root_path  
    end  
  end
  
  def search_form
  end
  
  def show_search_users
    if current_user.is_admin
      if params[:query] == ""
        flash[:partial] = "Please fill the form completly"
        redirect_to search_form_users_path
      else  
        if params[:search]== "1"
          @users = User.where("id like ?", "%#{params[:query]}%")
          #flash[:partial] = "no record found" if @users.length == 0
        else  
          if params[:search]== "2"
            @users = User.where("first_name like ?", "%#{params[:query]}%")    
            #flash[:partial] = "no record found" if @users.length == 0
          end
        end
      end  
    else 
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
  
  def admin_email_form
  end
  
  def admin_send_email
    @users = User.where(:is_admin => false)
    @sub=params[:sub]
    @body=params[:body]
    debugger
    @users.each do |user|
      AdminMailer.admin_email(user,@sub,@body)
    end
    redirect_to admin_email_form_users_path, notice:"emails are send successfully"
  end
  
end

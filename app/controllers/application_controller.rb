class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_category
  require 'will_paginate/array'
  
  def after_sign_in_path_for(resource)
    if current_user.present? and current_user.is_admin
      '/users/welcome' 
    else
      super
    end
  end
   
   def get_category
     @category = Category.all
   end  
   
   def authorize_admin
     (redirect_to root_path, notice:"Access denied") unless current_user.is_admin?
   end 
   
  def paginate_items(items)
    items.paginate(:page => params[:page], :per_page => 3)
  end
end

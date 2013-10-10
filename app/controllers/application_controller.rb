class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_category
  
   def after_sign_in_path_for(resource)
     if current_user.is_admin
       '/users/welcome' 
     else
       super
     end
   end
   
   def get_category
     @category = Category.all
   end   
   
end

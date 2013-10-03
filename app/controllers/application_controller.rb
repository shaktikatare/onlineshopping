class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :getcategory
  
   def after_sign_in_path_for(resource)
     if current_user.is_admin
       '/users/welcome' 
     else
       super
     end
   end
   
   def getcategory
     @category=Category.all
   end
   
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user
      sign_in_and_redirect @user, :event => :authentication, notice: "successfully signin with facebook acount"
    else
     redirect_to new_user_registration_url, notice:"User not found"
    end
      
    #if @user.persisted?
     # sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      #set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    #else
     # session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_user_registration_url
    #end
  end
  
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
      if @user
        sign_in_and_redirect @user, :event => :authentication, notice: "successfully signin with gmail acount"
      else
        redirect_to new_user_registration_url
      end
  end
  
end

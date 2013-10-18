Mydemo1::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #TODO Alignment should be proper.
  resources :products do
    collection do
      get :add_to_cart
      get :display_cart
      get :remove_from_cart
      get :show_search_products
      get :update_qty
    end
  end    
         
  resources :categories
  resources :orders do
    collection do
      get :change_status
      get :show_delivered_orders
      get :show_undelivered_orders
      get :search_form
      get :show_search_orders
    end
  end  
   
  resources :users do
    collection do
      get :welcome
      get :home
      get :search_form
      get :show_search_users
      get :admin_email_form
      get :admin_send_email
      get :signup_with_facebook
    end 
  end  
  
  root to: "users#home"

end

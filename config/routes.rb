Mydemo1::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :products do
    collection do
      get :add_to_cart
      get :display_cart
      get :remove_from_cart
      get :show_search_products
      get :show_product_images
      get :show_product_by_category
      get :remove_product_image
      get :update_qty
      get :change_availability
      get :show_unavailable_products
      get :show_available_products
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
      get :show_monthly_sales
      get :show_yearly_sales
    end
  end  
   
  resources :users do
    collection do
      get :welcome
      #get 'admin', to: 'users#welcome', as: :welcome
      get :home
      get :search_form
      get :show_search_users
      get :admin_email_form
      get :admin_send_email
    end 
  end  
  
  root to: "users#home"

end

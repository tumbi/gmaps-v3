Gmaps::Application.routes.draw do
  require 'subdomain'

  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_for :users do
    get "sign_out", :to => "devise/sessions#destroy"
    match "/users/update" => "users#update_user"
  end

  resources :plans do
    collection do
      get :choose_plan
    end
  end
  
#  constraints(Subdomain) do
    resources :characters do
      collection do
        get :view_full_map
        get :export_to_csv        
        post :import_records
        get :reminder_email
      end
      resources :markers
    end
    resources :sms
    resources :companies    
    resources :assets
    resources :notification_settings
    resources :company_users
    resources :templates do
      collection do
        get :update_template
      end
    end
#  end

  namespace :admin do
    #    constraints(Subdomain) do
    resources :users do
      collection do
        get :new_company
        post :create_company
        get :new_company_user
        post :create_company_user
      end
    end

    resources :characters do
      collection do
        get :view_full_map
        get :export_to_csv
        post :import_records
      end
    end
    resources :sms
    resources :companies
    resources :plans
    resources :assets
    resources :templates do
      collection do
        get :update_template
      end
    end
    #    end
  end

  root :to => 'welcome#index'
  #  root :to => 'characters#index'
  match "/set_position" => "characters#set_position"

  get "characters/:id/emailcontract" => "characters#send_contract", :as => "email_contract"
  get "characters/:id/smscontract" => "characters#send_sms", :as => "sms_contract"



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

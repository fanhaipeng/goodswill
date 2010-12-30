Goodswill::Application.routes.draw do
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  match 'donations/query' => 'donations#query', :via => :get, :as => 'donation_query'
  match 'donations/search' => 'donations#search', :via => :post, :as => 'donation_search'
  resources :donations
  resources :donations do
    resources :comments
  end

  resources :donation_images 
  resources :news
  resources :news do
    resources :news_images
  end
  resources :receivers
  
  resources :deliveries
  match 'deliveries/:id/pack' => 'deliveries#pack', :via => :put, :as => 'delivery_pack'
  match 'deliveries/:id/print_pack' => 'deliveries#print_pack', :via => :get, :as => 'delivery_print_pack'
  match 'deliveries/:id/print_ship' => 'deliveries#print_ship', :via => :get, :as => 'delivery_print_ship'
  resources :deliveries do
    resources :delivery_images
  end
  resources :images
  resources :users

  match 'account/login' => 'account#login'
  match 'account/login' => 'account#login', :via => :post
  match 'account/logout' => 'account#logout'

  match 'pick_up/index' => 'pick_up#index'
  match 'pick_up/:id' => 'pick_up#show', :via => :get, :as => 'pick_up_donation'
  match 'pick_up/:id' => 'pick_up#update', :via => :put, :as => 'pick_up_donation'

  match 'sort/index' => 'sort#index'
  match 'sort/:id' => 'sort#show', :via => :get, :as => 'sort_donation'
  match 'sort/:id' => 'sort#update', :via => :put, :as => 'sort_donation'


  match 'home/index' => 'home#index'
end

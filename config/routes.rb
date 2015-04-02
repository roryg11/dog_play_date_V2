Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

   resources :users

   get 'profile' => 'users#profile', as: :profile

   resources :dogs

   get '/parks/index' => 'parks#index'
   get '/parks/geojson' => 'parks#geojson', as: 'geojson'

   get '/signup' => 'registration#new', as: :signup
   post '/signup' => 'registration#create'
   get '/signin' => 'authentication#new', as: :signin
   post '/signin' => 'authentication#create'
   get '/signout' => 'authentication#destroy', as: :signout

   resources :conversations, :except=>[:new, :edit] do
     resources :messages
   end

   get '/preferences' => 'filters#index', as: :preferences
   post '/filters' => 'filters#create'
   get '/filters/:id/edit' => 'filters#edit', as: :edit_filter
   patch '/filters/:id' => 'filters#update'
   delete '/filters/:id' => 'filters#destroy', as: :filter

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

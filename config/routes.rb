Tf2movies::Application.routes.draw do
  root 'pages#welcome'

  get   '/404',     :to       => 'pages#not_found'
  get   '/500',     :to       => 'pages#internal_error'

  get   '/about',   :to       => 'pages#about',           :as => :about
  get   '/contact', :to       => 'pages#contact',         :as => :contact

  get   '/feed',    :to       => 'news_feed#feed',        :as => :feed, :defaults => { :format => 'atom' }

  get   '/login',   :to       => redirect('/auth/steam'), :as => :login
  match 'auth/steam/callback' => 'sessions#create',       :via => [:get, :post]
  post  '/logout',  :to       => 'sessions#destroy',      :as => :logout

  get '/search',    :to       => 'search#search',         :as => :search

  resources :authors, :only => [:show, :index]
  resources :users,   :only => [:show, :index]

  resources :regions, :game_modes, :tf2_classes do
    get 'manage', :on => :collection
  end

  resources :movies,  :only => [:show, :create, :index, :edit, :update] do
    member do
      post 'love'
    end
    collection do
      get 'submit'
      get 'manage'
    end
    resources :comments, :only => [:edit, :update, :create]
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

Rails.application.routes.draw do

  # Root Path
  root 'home#home'

  # Home Paths
  get '/about' => 'home#about'
  get '/dashboard' => 'home#dashboard', as: :dashboard

  # Registration Routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users' => 'users#index'

  # Login/Logout Routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Routes for taking an assessment
  get '/assessments' => 'assessments#index', as: :assessments
  get '/assessments/disclaimer' => 'assessments#disclaimer', as: :disclaimer_assessment
  get '/assessments/take' => 'assessments#disclaimer'
  post '/assessments/take' => 'assessments#take', as: :take_assessment
  post '/assessments/report' => 'assessments#generate_report', as: :generate_report_assessment
  get '/assessments/report' => 'assessments#report', as: :report_assessment
  get 'assessments/send_email' => 'assessments#send_email', as: :send_email

  # Model Resources for CRUD operations
  resources :competencies
  resources :paradigms
  resources :questions
  resources :levels
  resources :indicators
  resources :resources
  resources :indicator_questions
  resources :indicator_resources


  resources :imports do
    collection { post :parse }
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

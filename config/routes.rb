Rails.application.routes.draw do

    devise_for :users, controllers: {registrations: 'users/registrations',sessions: 'users/sessions',  omniauth_callbacks: 'users/omniauth_callbacks'}

    root "home#index" #Calls index method of home controller, then displays index view for home
    get 'home/about' #Creates a new route called "home_about"
    get 'home/terms_of_service'
    get 'home/privacy_policy'
    get 'home/contact'
    get 'home/faq'
    get 'home/sitemap'

    get 'personal_home/index'
    get 'personal_home/set_cookies'
    get '/personal_home/edit'=> 'users#edit'
    
    get 'ratings/new'
    # get '/login' => 'sessions#new'
    # post '/login' => 'sessions#create' 
    # delete '/logout' => 'sessions#destroy'
    # Add resource to get the standard RESTful actions for sessions
    #get 'sessions/new'

    resources :users
    resources :people
    resources :transactions
    resources :ratings

    get '/upload' => 'items#new'
    get '/user_items' => 'items#user_items'
    get '/search' => 'items#search'
    get '/remove_item/:id' => 'items#remove', as: 'remove_item'
    get '/borrow_item/:id' => 'items#borrow', as: 'borrow_item'
    resources :items

    #Friends part
    resources :friends do
      get :manage, on: :collection #on member requires ID, on collection doesn't
    end
    get '/accept_friend/:id' => 'friends#accept', as: 'accept_friend'
    get '/reject_friend/:id' => 'friends#reject', as: 'reject_friend'
    get '/acceptd_friend/:id' => 'friends#acceptd', as: 'acceptd_friend'
    get '/rejectd_friend/:id' => 'friends#rejectd', as: 'rejectd_friend'
    get '/search_friend' => 'friends#search', as: 'search_friend'
    get '/sendf_friend/:id' => 'friends#sendf', as: 'sendf_friend'
    get '/sendfd_friend/:id' => 'friends#sendfd', as: 'sendfd_friend'
    get '/remf_friend/:id' => 'friends#remf', as: 'remf_friend'
    get '/remfd_friend/:id' => 'friends#remfd', as: 'remfd_friend'
    get '/remr_friend/:id' => 'friends#remr', as: 'remr_friend'
    get '/remrd_friend/:id' => 'friends#remrd', as: 'remrd_friend'
    get '/ablock_friend/:id' => 'friends#ablock', as: 'ablock_friend'
    get '/ablockd_friend/:id' => 'friends#ablockd', as: 'ablockd_friend'
    get '/rblock_friend/:id' => 'friends#rblock', as: 'rblock_friend'

    #Notifications part
    get '/mall_phome' => 'personal_home#mall', as: 'mall_phome'
    get '/mone_phome/:id' => 'personal_home#mone', as: 'mone_phome'

end

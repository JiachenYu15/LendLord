Rails.application.routes.draw do

    root "home#index" #Calls index method of home controller, then displays index view for home
    get 'home/about' #Creates a new route called "home_about"

    get 'personal_home/index'
    get 'personal_home/set_cookies'
    get '/signup' => 'users#new'
    post '/signup' => 'users#create'

    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create' 
    delete '/logout' => 'sessions#destroy'
    # Add resource to get the standard RESTful actions for sessions
    #get 'sessions/new'

    resources :users
    resources :transactions

    get '/upload' => 'items#new'
    get '/user_items/:id' => 'items#user_items'
    get '/search' => 'items#search'
    get '/remove_item/:id' => 'items#remove', as: 'remove_item'
    get '/borrow_item/:id' => 'items#borrow', as: 'borrow_item'
    resources :items

end

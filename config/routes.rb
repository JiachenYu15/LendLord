Rails.application.routes.draw do
    root "home#index" #Calls index method of home controller, then displays index view for home
    get 'home/about' #Creates a new route called "home_about"
    get 'home/login'
    get 'home/signup'
    get 'home/personal_home'
end

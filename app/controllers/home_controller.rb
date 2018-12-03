class HomeController < ApplicationController

    #before_action :authenticate_user!, :unless => :devise_controller?

  def index
    if params.has_key?(:token)
      flash.now[:danger] = 'Payment is incomplete, please try again.'
    end
  end
    
  def about #Helps me link_to the about page
  end 

  def show

  end

  def personal_home
  end	

end

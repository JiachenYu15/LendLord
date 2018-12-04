class HomeController < ApplicationController

  skip_before_action :authenticate_user!
  skip_before_action :require_login

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

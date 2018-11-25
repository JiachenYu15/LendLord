class PersonalHomeController < ApplicationController
  def index
    @user_id = session[:user_id]
  end

  def set_cookies
    session[:user_id] = 1
  end

end

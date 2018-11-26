class PersonalHomeController < ApplicationController
  def index
    @user_id = session[:user_id]
    @your_transactions = Transaction.where(["borrow_from_user_id = ?",@user_id])
  end

  def set_cookies
    session[:user_id] = 1
  end

end

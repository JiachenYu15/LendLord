class FriendsController < ApplicationController
  #before_action :set_friend, only:[:update,:destroy]
    
  def index
    @friends = Friend.all
    @user = session[:user_id]
  end 

  def show
  end

  def new
    @friend = Friend.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
    @friend = Friend.new(friend_params)

    if @friend.save
      redirect_to friends_path, notice: 'Friend request sent successfully'
    else
      flash[:alert] = 'A problem occurred'
      render :new
    end

  end 

  def manage
    @myfriends = Friend.where(user_to_id: session[:user_id], has_accepted: false)
  end

  def accept
    @friend = Friend.find(params[:id])
    if @friend.update(has_accepted: true)
      flash[:alert] = "Success"
      redirect_to manage_friends_path
    else
      flash[:alert] = 'A problem occurred'
    end
  end

  def reject
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to manage_friends_path
  end

  private
    #def set_friend
    #  @friend = Friend.find(params[:id])
    #end

    def friend_params
      params.require(:friend).permit(:user_to_id).merge(user_from_id: session[:user_id], has_accepted: false)
    end

end

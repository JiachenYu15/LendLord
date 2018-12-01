class FriendsController < ApplicationController
    
  def index
    @friends = Friend.all
    @user = session[:user_id]
  end 

  def show
  end

  def new
    @friend = Friend.new
    @results = 0
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
    unless params[:field].blank?
      _field = params[:field].downcase
      _prev = ActiveRecord::Base.connection.exec_query("select a.id from users a where a.id != #{session[:user_id]} and lower(a.username) like '%#{_field}%'")
      if _prev.blank?
        @results = nil
      else
        _temp_users = Array.new
        _prev.each do |row|
          _check = ActiveRecord::Base.connection.exec_query("select id from friends where (user_from_id = #{session[:user_id]} and user_to_id = #{row['id']}) or (user_to_id = #{session[:user_id]} and user_from_id = #{row['id']})")
          if _check.blank?
            _temp_users.push(row['id'])
          end
        end
        if _temp_users.count > 0
          @results = ActiveRecord::Base.connection.exec_query("select a.id, a.username from users a where a.id in (#{_temp_users.join(', ')})")
        else
          @results = nil
        end
      end
    else
      @results = 0
    end
    render new_friend_path
  end

  def manage
    @myfriends = Friend.where(user_to_id: session[:user_id], has_accepted: false)
  end

  def accept
    @friend = Friend.find(params[:id])
    if @friend.update(has_accepted: true)
      redirect_to manage_friends_path, success: "You have a new friend!"
    else
      redirect_to manage_friends_path, danger: "An error ocurred"
    end
  end

  def reject
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to manage_friends_path, success: "Request succesfully declined"
  end

  def sendf
    @friend = Friend.new(user_from_id: session[:user_id], user_to_id: params[:id], has_accepted: false)
    if @friend.save
      redirect_to new_friend_path, success: "Friend request sent successfully"
    else
      redirect_to new_friend_path, danger: "An error ocurred"
    end
  end 

end

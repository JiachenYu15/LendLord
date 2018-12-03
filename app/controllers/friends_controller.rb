class FriendsController < ApplicationController
  before_action :require_login
    
  def index

    #myfriends contains all the friends the user has
    @myfriends = ActiveRecord::Base.connection.exec_query("(select a.id as ftid, a.user_from_id as fid, date(a.updated_at) as fsince, concat(b.firstname,' ',b.lastname) as uname, b.username as fuser from friends a, people b where a.user_to_id = #{current_user.id} and a.has_accepted=true and b.user_id = a.user_from_id) union (select a.id as ftid, a.user_to_id as fid, date(a.updated_at) as fsince, concat(b.firstname,' ',b.lastname) as uname, b.username as fuser from friends a, people b where a.user_from_id = #{current_user.id} and a.has_accepted=true and b.user_id = a.user_to_id)")
    
    #pendfriends contains all friends requests the user has sent
    @pendfriends = ActiveRecord::Base.connection.exec_query("select a.id, b.username, date(a.created_at) as dsend from friends a, people b where a.user_from_id = #{current_user.id} and a.has_accepted = false and b.user_id = a.user_to_id")

    #awaitfriends contains all friends requests the user has received
    @awaitfriends = ActiveRecord::Base.connection.exec_query("select a.id, b.username, date(a.created_at) as drecv from friends a, people b where a.user_to_id = #{current_user.id} and a.has_accepted = false and b.user_id = a.user_from_id")

    #@allfriends = Friend.all

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
      _prev = ActiveRecord::Base.connection.exec_query("select user_id from people where user_id != #{current_user.id} and lower(username) like '%#{_field}%'")
      if _prev.blank?
        @results = nil
      else
        _temp_users = Array.new
        _prev.each do |row|
          _check1 = ActiveRecord::Base.connection.exec_query("select id from friends where (user_from_id = #{current_user.id} and user_to_id = #{row['user_id']}) or (user_to_id = #{current_user.id} and user_from_id = #{row['user_id']})")
          _check2 = ActiveRecord::Base.connection.exec_query("select id from blocks where (block_from_id = #{current_user.id} and block_to_id = #{row['user_id']}) or (block_to_id = #{current_user.id} and block_from_id = #{row['user_id']})")
          if _check1.blank? and _check2.blank?
            _temp_users.push(row['user_id'])
          end
        end
        if _temp_users.count > 0
          @results = ActiveRecord::Base.connection.exec_query("select user_id, username from people where user_id in (#{_temp_users.join(', ')})")
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
    @blockfriends = ActiveRecord::Base.connection.exec_query("select a.id, b.username, date(a.created_at) as fsince from people b, blocks a where a.block_from_id = #{current_user.id} and b.user_id = a.block_to_id")
  end

  def accept
    @friend = Friend.find(params[:id])
    if @friend.update(has_accepted: true)
      _usr = Person.find_by user_id: current_user.id
      Notification.fwd(dest: @friend.user_from_id, msg:"#{_usr.username} has accepted your friend request")
      redirect_to friends_path, success: "Friend successfully added"
    else
      redirect_to friends_path, danger: "An error ocurred"
    end
  end

  def reject
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to friends_path, success: "Request succesfully declined"
  end

  def remf
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to friends_path, success: "Friend succesfully removed"
  end

  def remr
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to friends_path, success: "Request succesfully removed"
  end

  def sendf
    @friend = Friend.new(user_from_id: current_user.id, user_to_id: params[:id], has_accepted: false)
    if @friend.save
      _usr = Person.find_by user_id: current_user.id
      Notification.fwd(dest: @friend.user_to_id, msg:"#{_usr.username} has send you a friend request")
      redirect_to new_friend_path, success: "Friend request sent successfully"
    else
      redirect_to new_friend_path, danger: "An error ocurred"
    end
  end

  def ablock
    @block = Block.new(block_from_id: current_user.id, block_to_id: params[:id])
    if @block.save
      redirect_to new_friend_path, success: "User successfully blocked"
    else
      redirect_to new_friend_path, danger: "An error ocurred"
    end
  end

  def rblock
    @block = Block.find(params[:id])
    @block.destroy
    redirect_to manage_friends_path, success: "User successfully unblocked"
  end 

end

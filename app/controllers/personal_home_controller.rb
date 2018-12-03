class PersonalHomeController < ApplicationController

    def index
        @user_id = current_user.id
        @user = User.find(@user_id)
        @person = @user.person
        
        #Get the lending transactions
        @lend_items = Item.where(["user_id = ? AND is_available = ?", @user_id, false])
        ids = Array.new
        @lend_items.each do |x|
            ids.push(x.id)
        end
        @lend = Transaction.where(item_id: ids)
        
        #Get the borrowing transactions
        @borrow = Transaction.where(["user_id = ?",@user_id])

        @your_ratings = Rating.where(["ratee = ?", @user_id])
        @total_score = 0
    
        @your_ratings.each do |t|
            @total_score = @total_score + t.score
        end

        @rating_average = (@total_score.to_f / @your_ratings.size).round(2)
        
        #awaitfriends contains all friends requests the user has received
        @awaitfriends = ActiveRecord::Base.connection.exec_query("select a.id, b.username, date(a.created_at) as drecv from friends a, people b where a.user_to_id = #{current_user.id} and a.has_accepted = false and b.user_id = a.user_from_id")

        @notifications = Notification.where(["user_to_id = ? AND has_seen = false", @user_id])
                                                
    end                                
           
    def edit
        @user = User.find(session[:user_id])
    end

    def update 
        @user = User.find(params[:id])
        if @user.update_attributes(userparams)

        else
            render 'edit'
        end

    end

    def mone
      @notice = Notification.find(params[:id])
      if @notice.update(has_seen: true)
        redirect_to personal_home_index_path
      else
        redirect_to personal_home_index_path, danger: "An error ocurred"
      end
    end

    def mall
      @notice = Notification.where(["user_to_id = ? AND has_seen = false", session[:user_id]])
      if @notice.update_all(has_seen: true)
        redirect_to personal_home_index_path
      else
        redirect_to personal_home_index_path, danger: "An error ocurred"
      end
    end

    def rating
        @rating = Rating.new
    end

end

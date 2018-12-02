class PersonalHomeController < ApplicationController

    def index
        @user_id = session[:user_id]
        @user = User.find(@user_id)
        @lend = Transaction.where(["borrow_from_user_id = ?",@user_id])
        @borrow = Transaction.where(["lend_to_user_id = ?",@user_id])
        @your_ratings = Rating.where(["ratee = ?", @user_id])
        @total_score = 0
    
        @your_ratings.each do |t|
            @total_score = @total_score + t.score
        end

        @rating_average = (@total_score.to_f / @your_ratings.size).round(2)
         #awaitfriends contains all friends requests the user has received
        @awaitfriends = ActiveRecord::Base.connection.exec_query("select a.id, b.username, date(a.created_at) as drecv from friends a, users b where a.user_to_id = #{session[:user_id]} and a.has_accepted = false and b.id = a.user_from_id")

                                                
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

end

class PersonalHomeController < ApplicationController

    def index
        @user_id = session[:user_id]
        @user = User.find(@user_id)
        @your_transactions = Transaction.where(["borrow_from_user_id = ?",@user_id])
        @your_ratings = Rating.where(["ratee = ?", @user_id])
        @total_score = 0
    
        @your_ratings.each do |t|
            @total_score = @total_score + t.score
        end

        @rating_average = (@total_score.to_f / @your_ratings.size).round(2)
                                                
    end                                
           
    def edit
        @user = User.find(session[:user_id])
    end

end

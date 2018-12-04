class RatingController < ApplicationController

    def new
        @rating = Rating.new
    end

    def create
        @rating = Rating.new(rating_params)

        if @rating.save
            redirect_to personal_home_index_path
        end
    end

    private
        def rating_params
            params.require(:rating).permit(:rater, :ratee, :transaction_id, :score)
        end


end

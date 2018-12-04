class RatingsController < ApplicationController

    def new
        @rating = Rating.new
    end

    def create
        local_params = rating_params
        puts local_params
        local_params['rater'] = User.find(local_params['rater'])
        local_params['ratee'] = User.find(local_params['ratee'])
        puts local_params
        @rating = Rating.new(local_params)
        if @rating.save
            redirect_to personal_home_index_path
        end
    end

    private
        def rating_params
            params.require(:rating).permit(:rater, :ratee, :transaction_id, :score)
        end


end

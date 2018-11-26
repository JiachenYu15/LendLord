class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create

        @user = User.new(userparams)

        if @user.save
            # Handle a successful save
        else
            render 'new'
        end
    end

    private

    def userparams
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end

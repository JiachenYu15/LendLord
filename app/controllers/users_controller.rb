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
            log_in @user
            flash[:success] = "Welcome to LendLord!"
            redirect_to @user
        else 
            render 'new'
        end
    end

    private

        def userparams
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end

end

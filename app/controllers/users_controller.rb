class UsersController < ApplicationController

    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]

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
            redirect_to personal_home_index_path
        else 
            render 'new'
        end
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

    private

        def userparams
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end

        # Determine if a user is logged in or not
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end

        # Determine that a user can only edit their own profile
        def correct_user
            @user = User.find(session[:user_id])
            redirect_to(root_url) unless current_user?(@user)
        end
end

class ApplicationController < ActionController::Base

    before_action :authenticate_user!, :except => [:show, :index]
    before_action :require_login, :except => [:show, :index]
    #include SessionHelper

    add_flash_types :danger, :info, :warning, :success

    private

    def require_login
        unless current_user
            redirect_to new_user_session_path
        end
    end

end

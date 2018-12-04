class ApplicationController < ActionController::Base

    before_action :authenticate_user!, :except => [:show, :index, :about, :contact, :faq, :privacy_policy, :terms_of_service]
    before_action :require_login, :except => [:show, :index, :new]

    add_flash_types :danger, :info, :warning, :success, :notice

    private

    def require_login
        unless current_user
            redirect_to new_user_session_path
        end
    end

end

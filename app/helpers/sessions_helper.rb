module SessionsHelper

    # Logs in the given user
    def log_in(user)
        session[:user_id] = user.id
    end

    # Remembers user in persistent session.
    def remember(user)

        user.remember

        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # Return true if user is logged in; false otherwise
    def logged_in?
        !current_user.nil?
    end

    # Forget a persistent session
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # Logs out the given user
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    # Redirects to stored location (or to the default).
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    # Stores the URL trying to be accessed.
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end

    # Help to check if logged in or not
    def check_logged_in
      if session[:user_id]
        @user ||= User.find_by(id: session[:user_id])
      else
        redirect_to :controller => 'sessions', :action => 'new' and return false
      end
    end

end

class ApplicationController < ActionController::Base
    #CHR(R)LLL
    helper_method :current_user, :logged_in?
    #ask about sessions situation
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        current_user.reset_session_token! if logged_in? #dont have
        session[:session_token] = nil
        @current_user = nil
    end

    def logged_in?
        !!current_user # current_user.nil?
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def require_logged_out
        redirect_to cats_url if logged_in? #should not work now
    end
end
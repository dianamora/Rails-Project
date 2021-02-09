class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?
    #we need to make sure these are labeled as helper methods
    #it's private because these are not class methdods
    #the above will give us access to these methods in the views
    
    private
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
        

    end

    def logged_in?
        !!session[:user_id]
    end

    def redirect_if_not_logged_in
        redirect_to '/' if !logged_in?
    end

    
end

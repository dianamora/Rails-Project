class SessionsController < ApplicationController

    def home #technically do not need this unless you are setting a new thing in the controller
    end

    def destroy
        session.clear
        redirect_to root_path
    end

    def create
        user = User.find_by(username: params[:user][:username])
        if 
            user && user.authenticate(params[:user][:password]) #if user is found and password is correct
            session[:user_id] = user.id
            redirect_to user_path(user)
        else 
            flash[:message] = "No match with that username or password. Please try again"
            redirect_to "/login"
        end
    end


end
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

    
def omniauth #if they are logging in with oauth
        # if that user has already logged in this way
        user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |u|
            u.email = auth["info"]["email"]
            u.password = SecureRandom.hex(15)
            u.username = auth["info"]["email"]
        end
            if user.valid?
                session[:user_id] = user.id   #log them in
                redirect_to user_path(user)
            else
                flash[:message] = "Oopsie! Something's wrong!"
                redirect_to login_path
            end
end

private

def auth
    request.env['omniauth.auth']
end

    # def omniauth
    #     user = User.create_from_omniauth(auth)
    #     if user.valid?
    #         session[:current_user_id] = user.id
    #         flash[:message] = "You have successfully signed in with Google Oauth"
    #         redirect_to user_path(user)
    #     else
    #         flash[:message] = user.errors.full_messages.join(", ")
    #         redirect_to "/"
    #     end
    # end 


end
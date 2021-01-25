class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create #if info saves successfully, log my user in and redirect to show page
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new #take them back to the sign up page if info doesn't save
        end
    end

    def show
        redirect_if_not_logged_in #method from app controller
        @user = User.find_by_id(params[:id]) #.find will throw an error if it doesn't find soemething, .find_by will return 'nil'
        redirect_to '/' if !@user #you want to redirct to a user never seens an error page if id not found
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end

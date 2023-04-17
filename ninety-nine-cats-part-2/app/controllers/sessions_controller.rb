class SessionsController < ApplicationController
    def new
        @user = User.new 
        render :new 
    end

    def create 
        username = params[:user][:username]
        password = params[:user][:password]

        @user = User.find_by_credentials(username, password)

        if @user 
            login!(@user)
            redirect_to user_url(@user)
        else 
            @user = User.new(username: username)
            render :new 
        end 
    end
end

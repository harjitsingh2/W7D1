class UsersController < ApplicationController

    before_action :require_logged_out, only: [ :new, :create ]
    before_action :require_logged_in, only: [ :index, :show, :edit, :update ]

    def new 
        @user = User.new
        render :new
    end

    def create 
    
    end

    private 
    def user_params
        params.require(:user).permit(:username, :password)
    end 
end

class UsersController < ApplicationController
    before_action :find_user, only: [:show]
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            @user.send_activation_email
            redirect_to root_path
        else
            render 'new'
        end
    end

    def show

    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def find_user
        @user = User.find(params[:id])
    end
end

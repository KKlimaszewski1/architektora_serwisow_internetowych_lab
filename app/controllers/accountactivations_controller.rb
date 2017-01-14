class AccountactivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.activate
            login user
            flash[:success] = "Konto zostało aktywowane."
            redirect_to root_url
        else
            flash[:danger] = "Niewłaściwy link aktywacyjny."
            redirect_to root_url
        end
    end
end

class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            if user.activated?
                login user
                params[:session][:remember_me] == '1' ? remember(user) : forget(user)
                redirect_to root_path
            else
                message = "Konto jest nieaktywne."
                message += "Sprawdz swój email i kliknij w link aktywacyjny."
                flash[:warning] = message
                redirect_to root_url
            end
        else
            flash[:warning] = "Błędny login lub hasło."
            redirect_to :back
        end
    end

    def destroy
        logout if sign_in? 
        redirect_to root_path
    end

end

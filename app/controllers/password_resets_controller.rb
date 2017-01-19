class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      flash[:warning] = "Na wskazany email wysłano dalszą instrukcję."
      redirect_to root_url
    else
      flash[:warning] = "W bazie nie ma konta o wskazanym adresie email."
      redirect_to new_password_reset_path
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path
      flash[:warning] = "Możliwość zmiany hasła wygasła po 2 godzinach od wysłania wiadomości. W celu zmiany hasła odwiedz naszą stronę i zrestartuj hasło ponownie."
    elsif @user.update_attributes(user_params)
      redirect_to root_url
      flash[:success] = "Hasło zostało zmienione."
    else
      render :edit
    end
  end

  private
        
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

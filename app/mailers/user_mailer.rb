class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail :to => user.email, :subject => "Aktywacja konta w serwisie Książka Kucharska"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Restart hasła do serwisu Książka Kucharska"
  end
end

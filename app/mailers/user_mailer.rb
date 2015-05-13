class UserMailer < ApplicationMailer
  default from: "Codenamecrud.ru"

  def welcome_email(user)
    @user = user
    @url  = 'http://codenamecrud.ru/'
    mail(to: @user.email, subject: 'Добро пожаловать на Сodenamecrud.ru') do |format|
      format.html { render layout: '../user_mailer/welcome_email' }
    end
  end

end

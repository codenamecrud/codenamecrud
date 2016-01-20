class UserMailer < ApplicationMailer
  default from: 'frey@list.ru'

  def welcome_email(user)
    @user = user
    @url  = 'http://codenamecrud.ru/'
    mail(to: @user.email, subject: 'Добро пожаловать на Сodenamecrud.ru',
         template_path: 'user_mailer', template_name: 'welcome_email')
  end
end

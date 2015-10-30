class UserMailer < ApplicationMailer
  
  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Rotten Mangoes')
  end

  def goodbye_email(user)
    @user = user
    @url = 'http://rottenmangoes.com'
    mail(to: @user.email, subject: 'We\'re sorry to see you go!')
  end

end

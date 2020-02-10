class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/#{@user.id}/welcome"
    mail(to: @user.email, subject: '私の素敵なサイトへようこそ')
  end
end

class UserMailer < ActionMailer::Base
  default :from => "gracedimension@gmail.com"

  def registration_confirmation(user)
    @user = user
    @url = "http://gracedimension.com"
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end

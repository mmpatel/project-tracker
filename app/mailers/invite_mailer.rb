class InviteMailer < ActionMailer::Base

  def invite_team(from, email)
    mail(to: email, from: from, subject: 'Please login to my site')
  end

end

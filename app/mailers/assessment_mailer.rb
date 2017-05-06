class AssessmentMailer < ApplicationMailer
  default :from => "competentu@outlook.com"

  def send_assessment(user_email,link)
    @user_email = user_email
    @link  = link
    mail(:to => user_email, :subject => "Your CompetentU Assessment Report")
  end
end

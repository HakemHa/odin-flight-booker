class PassengerMailer < ApplicationMailer
  default from: "project@odin.com"
  def confirmation_email
    @passenger = params[:passenger]
    mail(to: @passenger.email, subject: "Confirmation Email")
  end
end

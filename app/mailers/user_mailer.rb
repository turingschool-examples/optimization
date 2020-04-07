class UserMailer < ApplicationMailer
  def promo_email
    @user = params[:user]
    mail(to: @user.email, subject: "Limited Time Offer!")
  end
end

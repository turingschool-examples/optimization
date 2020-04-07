class Admin::PromotionsController < ApplicationController
  def create
    User.find_each do |user|
      UserMailer.with(user: user).promo_email.deliver_now
    end
    redirect_to admin_users_path
  end
end

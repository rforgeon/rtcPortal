class DashboardsController < ApplicationController

  before_filter :authenticate_user!

  Stripe.api_key = ENV["STRIPE_API_KEY"]

  def Show
    @customer = Stripe::Customer.where(email = user.email)

  end

end

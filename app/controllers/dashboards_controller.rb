class DashboardsController < ApplicationController

  before_action :authenticate_user!

  Stripe.api_key = ENV["STRIPE_API_KEY"]


  def show
    if current_user.stripe_id == nil || current_user.subscribed == nil
      @customer = nil
    else
      @customer = Stripe::Customer.retrieve(current_user.stripe_id)
    end
  end

end

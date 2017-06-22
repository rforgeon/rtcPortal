class SubscriptionController < ApplicationController

  Stripe.api_key = ENV["STRIPE_API_KEY"]

  def plans
    #binding.pry
    @stripe_list = Stripe::Plan.all
    @plans = @stripe_list[:data]
  end

  # This is the callback from stripe
  def subscription_checkout

    plan_id = params[:plan_id]
    plan = Stripe::Plan.retrieve(plan_id)
    #This should be created on signup.
    customer = Stripe::Customer.create(
            #:description => "Customer for test@example.com",
            :source => params[:stripeToken],
            :email => current_user.email
          )

    user = current_user
    user.stripe_id = customer.id
    user.subscribed = true
    user.save

    # Save this in your DB and associate with the user;s email
    stripe_subscription = customer.subscriptions.create(:plan => plan.id)

    flash[:notice] = "Successfully Subscribed!"
    redirect_to '/dashboard'
  end

end

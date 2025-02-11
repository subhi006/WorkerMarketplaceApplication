class PaymentsController < ApplicationController
  before_action :authenticate_user!
  # def new
  # end

  def create
    @salary = params[:salary]
    @user = User.find(params[:id])
    # create stripe customer for payment, update if already created

    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
    "price" => Stripe::Price.create(
        unit_amount: @salary.to_i,
         currency: "usd",
         product_data: { name: @user.full_name }
         ),
    quantity: 1
  } ],
      # "line_items" => [
      # "price" => Stripe::Price.create(
      #   unit_amount: @salary.to_i,
      #    currency: "usd",
      #    product_data: { name: @user.full_name }
      #    ),
      # "quantity" => 2
      #             ],
      mode: "payment",
      # ui_mode: "embedded",
      success_url:  payments_success_url,
      cancel_url: payments_cancel_url
     )
    #  respond_to do |formate|
    #    formate.html
    #  end
    redirect_to session.url, status: 303, allow_other_host: true
  end

  def success
    # handle successful payments
    # redirect_to root_url, notice: "Purchase Successful"
  end

  def cancel
    # handle if the payment is cancelled
    redirect_to root_url, notice: "Purchase Unsuccessful"
  end
  # def create
  #   @user=User.find(params[:id])
  #   @salary = params[:salary]
  #     @session = Stripe::Checkout::Session.create(
  #       payment_method_types: [ "card" ],
  # line_items: [ {
  #   price_data: {
  #     currency: "usd",
  #     product_data: {
  #       name: @user.full_name
  #     },
  #     unit_amount: 1000
  #   },
  #   quantity: 1
  # } ],
  #       mode: "payment",
  #       success_url: root_url + "?session_id={CHECKOUT_SESSION_ID}",
  #       cancel_url: root_url
  #     )

  #     render json: { id: session.id }
  # end

  # def success
  # end
  #   @amount = 500

  #   customer = Stripe::Customer.create(
  #     email: params[:stripeEmail],
  #     source: params[:stripeToken]
  #   )

  #   charge = Stripe::Charge.create(
  #     customer: customer.id,
  #     amount: @amount,
  #     description: "Rails Stripe customer",
  #     currency: "usd"
  #   )

  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to new_payment_path
  # end
end

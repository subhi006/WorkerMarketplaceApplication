class PaymentsController < ApplicationController
  before_action :authenticate_user!
  # def new
  # end

  def create
    # authorize! :create, Payments

    task = Task.find(params[:task_id])
    user = User.find(params[:id])

    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        "price" => Stripe::Price.create(
        unit_amount: task.salary.to_i,
        currency: "usd",
        product_data: { name: user.full_name }
        ),
        quantity: 1
        } ],
      mode: "payment",
      success_url:  "#{payments_success_url}?user_id=#{user.id}&task_id=#{task.id}",
      cancel_url: "#{payments_cancel_url}?id=#{task.id}"
     )
    redirect_to session.url, status: 303, allow_other_host: true
  end

  def success
    @task = Task.find(params[:task_id])
    @user = User.find(params[:user_id])
  end

  def cancel
    @task = Task.find(params(:id))
    redirect_back assigned_task_path(@task), alert: "Payment was cenceled"
  end
end

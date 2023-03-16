class PaymentController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'stripe'

  def create_payment_order(value, mode)
    amount = session[:totals] if session[:totals].present?
    trans_id = value
    address = UserAddress.last
    order = UserOrder.create(user_id: current_user.id, user_address_id: address.id, transaction_id: trans_id, Total_amount: amount, payment_gateway: mode)
    if order.save
      @cart_products.each do |product|
        order.order_details.create(product_id: product.id, amount: product.price, quantity: product.quantity)
      end
      UserMailer.placemail(current_user, order).deliver
      UserMailer.ordermail(current_user, order).deliver
    end
  end

  def stripe_paymet_success
    response = Stripe::Checkout::Session.retrieve(id: params[:session_id])
    @pay_id = response[:payment_intent]
    mode = 'Stripe'
    @total = response[:amount_total] / 100
    @user_order = UserOrder.last
    PaymentResponse.create(transation_id: response[:payment_intent], amount: @total)
    create_payment_order(@pay_id, mode)
    session[:cart] = nil
  end

  def stripe_payment
    success_url =  'http://localhost:3000/payment/stripe_paymet_success?true&session_id={CHECKOUT_SESSION_ID}'
    stripe_params = { success_url: success_url, cancel_url: root_url, final_amount: params[:final_amount].to_i }
    @session =  StripePayment.execute(stripe_params: stripe_params)
  end

  def cod
    transaction_id = 1
    mode = 'COD'
    @final_value = session[:totals] if session[:totals].present?
    @user_order = UserOrder.last
    create_payment_order(transaction_id, mode)
    session[:cart] = nil
  end
end

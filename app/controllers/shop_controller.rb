class ShopController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'stripe'

  def checkout_product
    amount = session[:totals]
    @@trans == 1 ? ( payment_gateway = 'COD', trans_id = 1 ) : ( payment_gateway = 'Stripe', trans_id = @@trans )
    address = UserAddress.last
    order = UserOrder.create( user_id: current_user.id,user_address_id: address.id, transaction_id: trans_id, Total_amount: amount, payment_gateway: payment_gateway )
    if order.save
      @cart_products.each do |product|
        order.order_details.create(product_id: product.id, amount:product.price, quantity: product.quantity)
      end 
       UserMailer.placemail(current_user,order).deliver
       UserMailer.ordermail(current_user,order).deliver
    end
  end

  def success
    Stripe.api_key = 'sk_test_51MD3qeSA33xedoIC2YAMsbM8jTPXNscjdxlbwAbWbtaApaRe3F6ZFXF5MR2uRaOlkvKva3Am0ev7AYSZHbMP5u8v00kK6dGWkg'
    response = Stripe::Checkout::Session.retrieve( id: params[:session_id] )
    @pay_id = response[:payment_intent]
    @@trans = @pay_id
    pay_amount=response[:amount_total]
    amount=pay_amount/100
    @total = amount
    pay_response = PaymentResponse.create(transation_id: response[:payment_intent], amount: amount)
    @user_order = UserOrder.last
    checkout_product
    session[:cart] = nil
  end

  def stripe
    @final_value = params[:final_amount].to_i
    product=Stripe::Product.create({name: 'Order 1'})
    @session = Stripe::Checkout::Session.create
              ({ payment_method_types: ['card'],
                 line_items: [
                 price_data: {
                 product: product.id,
                 unit_amount:@final_value*100,
                 currency: 'usd' },
                 quantity: 1, ],
                 mode: 'payment',
                 success_url: 'http://localhost:3000/shop/success?true&session_id={CHECKOUT_SESSION_ID}',
                 cancel_url: root_url
              })    
  end

  def cod
    @@trans = 1
    checkout_product
    @f_value = session[:totals]
    @user_order = UserOrder.last
    session[:cart] = nil
  end
end 
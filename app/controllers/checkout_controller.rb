class CheckoutController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def show
    amount
    
    product=Stripe::Product.create({name: 'Order 1'})
    Stripe::Price.create({
    unit_amount: @value*100,
    currency: 'usd',
    product: product.id,})
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
      price_data: {
      product: product.id,
      unit_amount: @value*100,
      currency: 'usd'},
      quantity: 1,],
      
      mode: 'payment',
      success_url: 'http://localhost:3000/shop/success?true&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,})    
  end
  
  def success
  end

  def amount
    # order = current_user.orders.build
    # order.order_details.create(product_id: id)
    product_price_lists = [] 
    @cart.each do |product| 
      total_value = (product.quantity)*(product.price)
      product_price_lists << total_value
    end
    @total_price = product_price_lists.inject {|sum,price| sum + price}
    @value = @total_price.to_i
  end

  def cod
    amount
    @user_order = UserOrder.last
  end

end 




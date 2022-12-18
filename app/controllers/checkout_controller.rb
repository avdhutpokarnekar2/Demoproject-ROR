class CheckoutController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def show
    product_price_lists = [] 
    @cart.each do |product| 
    temp = (product.quantity)*(product.price)
    product_price_lists << temp
    end
    @total_price = product_price_lists.inject {|sum,price| sum + price}
    @value = @total_price.to_i
    
    product=Stripe::Product.create({
      name: 'Order 1'
      })
      Stripe::Price.create({
      unit_amount: @value.to_i*100,
      # product: {{product.id}},
      currency: 'usd',
      product: product.id,
      })
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [
        price_data: {
        product: product.id,
        unit_amount: @value.to_i*100,
        currency: 'usd'
      },
      quantity: 1,
      ],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
      })
puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#{@session.id}"
  end
end 
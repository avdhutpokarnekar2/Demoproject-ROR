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
    
    product=Stripe::Product.create({name: 'Order 1'})
    Stripe::Price.create({
    unit_amount: @value.to_i*100,
    # product: {{product.id}},
    currency: 'usd',
    product: product.id,})
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
      price_data: {
      product: product.id,
      unit_amount: @value.to_i*100,
      currency: 'usd'},
      quantity: 1,],
      
      mode: 'payment',
      success_url: 'http://localhost:3000/shop/success?true&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,})    
  end
end 









# puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#{@session.id}"
#pi_3MGIIzSA33xedoIC1AxiL5Vy
#pi_1GswaK2eZvKYlo2Co7wmNJhD
#cs_test_a1oJYixfDMEnlvPWarP0Dkwou2VpdCbJrsqA1fUW1WniEn0KD0YCsf61j6

 # curl -G https://api.stripe.com/v1/issuing/transactions \
 #   -u sk_test_51MD3qeSA33xedoIC2YAMsbM8jTPXNscjdxlbwAbWbtaApaRe3F6ZFXF5MR2uRaOlkvKva3Am0ev7AYSZHbMP5u8v00kK6dGWkg: \
 #   -d limit=3
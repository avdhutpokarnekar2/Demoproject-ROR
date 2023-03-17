class StripePayment
  def self.execute(stripe_params:)
    product=Stripe::Product.create({name: 'Order 1'})
    @session = Stripe::Checkout::Session.create({payment_method_types: ['card'],
            line_items: [
            price_data: {
            product: product.id,
            unit_amount: stripe_params[:final_amount]*100,
            currency: 'inr'},
            quantity: 1,],
            mode: 'payment',
            success_url: 'http://localhost:3000/payment/stripe_paymet_success?true&session_id={CHECKOUT_SESSION_ID}',
            cancel_url: stripe_params[:cancel_url]
            })
  end
end

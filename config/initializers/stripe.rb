require 'stripe'
Rails.configuration.stripe = {
:publishable_key => ENV['pk_test_51MD3qeSA33xedoICWGqzUb9rvgFVipYiW57epwquiLFA4oKZbhKGFf1UxVVEYsJ4HiiRrhELtNkOd24Bfv5UfT0M00LNp28wdM'],
:secret_key => ENV['sk_test_51MD3qeSA33xedoIC2YAMsbM8jTPXNscjdxlbwAbWbtaApaRe3F6ZFXF5MR2uRaOlkvKva3Am0ev7AYSZHbMP5u8v00kK6dGWkg']}
Stripe.api_key = 'sk_test_51MD3qeSA33xedoIC2YAMsbM8jTPXNscjdxlbwAbWbtaApaRe3F6ZFXF5MR2uRaOlkvKva3Am0ev7AYSZHbMP5u8v00kK6dGWkg'

 
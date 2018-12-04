# frozen_string_literal: true

module ItemsHelper

  # Config PayPal payment layout to match our LendLord info
  def fetch_paypal_web_experience_profile(profile_name: 'lendlord_template_experience_profile')

    experience_profiles = PayPal::SDK::REST::WebProfile.get_list
    experience_profile = experience_profiles.find { |profile| profile.name == profile_name }

    if experience_profile.nil?
      experience_profile = PayPal::SDK::REST::WebProfile.new(
        name: profile_name,
        temporary: false,
        input_fields: {
          no_shipping: 1,
          address_override: 1
        },
        flow_config: {
          landing_page_type: 'Login'
        }
      )
      experience_profile.create
    end

    experience_profile
  end

  # Initialize payment object
  def create_paypal_payment?
    fetch_paypal_web_experience_profile
    payment = PayPal::SDK::REST::Payment.new(
      intent: 'sale',
      # Set payment type
      payer: {
        payment_method: 'paypal'
      },
      # Set transaction object
      transactions: [{
        # Items
        item_list: {
          items: [{
            name: @item.name.to_s,
            sku: @item.id.to_s,
            price: @item.deposit.to_s,
            currency: 'CAD',
            quantity: 1
          }]
        },
        # Amount - must match item list breakdown price
        amount: {
          total: @item.deposit.to_s,
          currency: 'CAD'
        },
        description: @item.description.to_s
      }],
      experience_profile_id: fetch_paypal_web_experience_profile.id,
      # Set redirect URLs
      redirect_urls: {
        return_url: "http://lendlord.herokuapp.com/transactions/new?itemID=#{@item.id}",
        cancel_url: 'http://lendlord.herokuapp.com/' # Redirected to index with flash
      }
    )
    # Create payment
    if payment.create
      # Capture redirect url
      redirect_url = payment.links.find { |v| v.rel == 'approval_url' }.href
      redirect_to(redirect_url)
      return true
    else
      return false
    end
  end

end

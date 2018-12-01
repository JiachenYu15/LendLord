module TransactionsHelper

  def execute_paypal_payment?
    # Get payment ID from parameters received by redirecting
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
    # Execute payment with Payer ID
    # Return true or false
    return payment.execute(payer_id: params[:PayerID])
  end

end

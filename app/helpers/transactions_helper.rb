module TransactionsHelper

  def execute_paypal_payment?
    # Get payment ID from parameters received by redirecting
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
    # Execute payment with Payer ID
    # Return true or false
    return payment.execute(payer_id: params[:PayerID])
  end

  # def refund_paypal_payment?(payment_id)
  #   payment = PayPal::SDK::REST::Payment.find(payment_id)
  #   sale = payment.transactions[0].related_resources[0].sale
  #
  #   refund = sale.refund_request
  #
  #   # Check refund status
  #   if refund.success?
  #     puts "Refund[#{@refund.id}] Success"
  #   else
  #     puts "Unable to Refund"
  #     puts @refund.error.inspect
  #   end
  #
  # end

end

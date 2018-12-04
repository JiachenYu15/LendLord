require 'action_view'
include ActionView::Helpers::NumberHelper

module TransactionsHelper
  def execute_paypal_payment?
    # Get payment ID from parameters received by redirecting
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])
    # Execute payment with Payer ID
    # Return true or false
    return payment.execute(payer_id: params[:PayerID])
  end

  def refund_paypal_payment?(payment_id)
    payment = PayPal::SDK::REST::Payment.find(payment_id)
    sale = payment.transactions[0].related_resources[0].sale
    deposit = number_with_precision(@returned_item.deposit, precision: 2)
    refund = sale.refund_request(
      amount: {
        total: "#{deposit}",
        currency: 'CAD'})

    # Check refund status
    if refund.success?
      return true
    else
      return false
    end
  end
end

class TransactionsController < ApplicationController

  include TransactionsHelper

  def index
    check_logged_in

    @transactions = Transaction.all
  end

  def show
    check_logged_in

    @transaction = Transaction.find(params[:id])
  end

  def new
    check_logged_in
    @item = Item.find(params['itemID'])
    @payment_id = params['paymentId']
    @token = params['token']
    @payer_id = params['PayerID']
    @transaction = Transaction.new
    # refund_paypal_payment?(params[:paymentId])
  end

  def edit
    check_logged_in

    @transaction = Transaction.find(params[:id])
  end

  def create
    @item = Item.find(transaction_params[:item_id])
    unless execute_paypal_payment?
      redirect_to({ controller: 'items',
                    id: transaction_params[:item_id],
                    action: 'show' },
                  alert: 'Cannot execute PayPal payment, please try again later.' ) and return
    end
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      @item.is_available = false
      if @item.save
      redirect_to ({ controller: 'items',
                     id: transaction_params[:item_id],
                     action: 'show',
                     transaction_state: 'created' })
      else
        redirect_to({ controller: 'items',
                      id: transaction_params[:item_id],
                      action: 'show' },
                    alert: 'Item is not available right now, please ask for refund.' ) and return
      end
    else
      redirect_to({ controller: 'items',
                    id: transaction_params[:item_id],
                    action: 'show' },
                  alert: 'Cannot process your request, please ask for refund.' ) and return
    end
  end

  def update
    check_logged_in

    @transaction = Transaction.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to @transaction
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    redirect_to transactions_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:item_id,
                                        :user_id,
                                        :start_date,
                                        :due_date,
                                        :deposit,
                                        :status,
                                        :payment_id)
  end

end

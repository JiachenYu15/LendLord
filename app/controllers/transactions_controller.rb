class TransactionsController < ApplicationController

  include TransactionsHelper

  def index
    @user = current_user
    # Get all lending record
    @lend_items = Item.where(["person_id = ?", @user.person.id])
    @lend_transactions = Transaction.where(item_id: @lend_items.ids)
    # Get all borrow record
    @borrow_transactions = Transaction.where(["user_id = ?", @user.id])
  end

  def show

    @transaction = Transaction.find(params[:id])
  end

  def new
    @user = current_user
    @item = Item.find(params['itemID'])
    @payment_id = params['paymentId']
    @token = params['token']
    @payer_id = params['PayerID']
    @transaction = Transaction.new
    # refund_paypal_payment?(params[:paymentId])
  end

  def edit

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
    transaction = {'id' => params[:id], 'status' => params[:status]}
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction)
      if transaction['status'] == 'returned'
        redirect_to ({ controller: 'ratings',
                       action: 'new',
                       transaction_id: @transaction.id,
                       rating_user_id: current_user.id,
                       ratted_user_id: @transaction.item.person.user_id}) and return
      end
      if transaction['status'] == 'closed'
        @returned_item = Item.find(@transaction.item_id)
        @returned_item.is_available = true
        @returned_item.save
        refund_paypal_payment?(@transaction.payment_id)
        redirect_to ({ controller: 'ratings',
                       action: 'new',
                       transaction_id: @transaction.id,
                       rating_user_id: current_user.id,
                       ratted_user_id: @transaction.user_id}) and return
      end
      if transaction['status'] == 'rejected'
        @returned_item = Item.find(@transaction.item_id)
        @returned_item.is_available = true
        @returned_item.save
        refund_paypal_payment?(@transaction.payment_id)
      end
      redirect_to personal_home_index_path
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

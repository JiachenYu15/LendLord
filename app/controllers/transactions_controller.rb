class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def edit

  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction
    else
      render 'new'
    end
  end

  def update

  end

  def destroy

  end

  private

  def transaction_params
    params.require(:transaction).permit(:item_id,
                                        :borrow_from_user_id,
                                        :lend_to_user_id,
                                        :start_date,
                                        :due_date,
                                        :deposit,
                                        :status)
  end

end

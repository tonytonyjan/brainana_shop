class TransactionsController < ApplicationController
  def show
    @transaction = Transaction.find_by trade_number: params[:id]
  end
end

module Api
  module V1
    class TransactionsController < ApplicationController
      def create 
        transaction = Transaction.create!(transaction_params)
        transaction.categorise
        render json: transaction.reload, status: :ok
      end

      private

      def transaction_params
        params.require(:transaction).permit(
          :posted_date,
          :currency,
          :amount,
          :description,
          :type
        )
      end
    end
  end
end

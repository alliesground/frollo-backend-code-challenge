module Api
  module V1
    class TransactionsController < ApplicationController
      def create 
        transaction = Transaction.create(transaction_params)

        if transaction.persisted?
          render json: transaction, status: :ok
        else
          render json: {message: transaction.errors.full_messages}, 
            status: :unprocessable_entity
        end
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

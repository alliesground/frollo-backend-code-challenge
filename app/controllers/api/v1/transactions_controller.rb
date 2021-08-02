module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_transaction, only: :show

      def create 
        transaction = Transaction.create!(transaction_params)
        transaction.categorise
        render json: transaction.reload, status: :ok
      end

      def show
        render json: @transaction, status: :ok
      end

      private

      def set_transaction
        @transaction = Transaction.find(params[:id])
      end

      def transaction_params
        params.require(:transaction).permit(
          :posted_date,
          :currency,
          :amount,
          :description,
          :type,
          :category
        )
      end
    end
  end
end

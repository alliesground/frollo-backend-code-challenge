require 'rails_helper'

RSpec.describe 'Api::V1::TransactionsController', type: :request do
  describe 'POST /api/transactions' do

    context 'with valid request' do
      before :each do 
        post('/api/transactions',
             params: { transaction: attributes_for(:transaction)})
      end

      it 'creates a transaction' do
        expect(Transaction.count).to eq 1
      end

      it 'responds with status 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid request' do
      before :each do
        post('/api/transactions',
             params: { transaction: attributes_for(:invalid_transaction)})
      end

      it 'does not create a transaction' do
        expect(Transaction.count).to eq 0
      end

      it 'responds with status 404' do
        expect(response).to have_http_status(422)
      end
    end
  end
end

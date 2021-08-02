require 'rails_helper'

RSpec.describe 'Api::V1::TransactionsController', type: :request do
  describe 'POST /api/transactions' do

    context 'with valid request' do
      context 'before categorisation' do
        before do 
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

      context 'after categorisation' do
        it 'categorises the newly created transaction' do
          expect_any_instance_of(Transaction).to receive(:categorise)
          post('/api/transactions',
               params: { transaction: attributes_for(:transaction)})
        end
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

  describe 'GET /api/transaction/:id' do
    context 'when transaction exists' do
      let!(:transaction) { create(:transaction) }

      before :each do
        get "/api/transactions/#{transaction.id}"
      end

      it 'responds with status 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the transaction' do
        expect(json_response['id']).to eq transaction.id
      end
    end

    context 'when transaction does not exist' do
      it 'responds with status 404' do
        get "/api/transactions/1"
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'GET /api/transactions' do
    let!(:transactions) { create_list(:transaction, 2) }

    before do 
      get '/api/transactions'
    end

    it 'returns list of transactions' do
      expect(json_response.size).to eq 2
    end

    it 'responds with status 201' do
      expect(response).to have_http_status 201
    end
  end
end

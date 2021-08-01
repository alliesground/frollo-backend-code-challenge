require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Transaction, type: :model do
  it do
    should validate_inclusion_of(:currency).
      in_array(['AUD', 'USD', 'GPD'])
  end

  it do
    should validate_inclusion_of(:type).
      in_array(['TRANSFER_OUTGOING', 
                'TRANSFER_INCOMING', 
                'PAYMENT',
                'OTHER'])
  end

  it do
    should validate_length_of(:description).
      is_at_most(300)
  end

  describe '#categorise' do
    let(:transaction) { create(:transaction) }
    before do
      Sidekiq.stub(:redis).and_return(nil)
    end

    it 'queues categorisation job' do
      expect {
        transaction.categorise
      }.to change{ Categoriser.jobs.size }
    end
  end
end

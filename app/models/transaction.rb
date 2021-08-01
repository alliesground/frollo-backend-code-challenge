class Transaction < ApplicationRecord
  self.inheritance_column = :_type_disabled

  validates_inclusion_of :currency, 
    in: ['AUD', 'USD', 'GPD']

  validates_inclusion_of :type,
    in: ['TRANSFER_OUTGOING', 
         'TRANSFER_INCOMING', 
         'PAYMENT',
         'OTHER']

  validates_length_of :description, maximum: 300

  def categorise
    Categoriser.perform_async(description, amount, type, id)

    # wating for job to finish before returning the categorised result
    Sidekiq.redis do |conn|
      conn.subscribe("categorisation") do |on|
        on.message do |channel, msg|
          if msg == "success"
            conn.unsubscribe
          end
        end
      end
    end
  end
end

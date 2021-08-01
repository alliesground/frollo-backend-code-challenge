class Categoriser
  include Sidekiq::Worker

  def perform(description, amount, transaction_type, transaction_id)
    category = Categorisation.categorise(description, amount, transaction_type)

    transaction = Transaction.find(transaction_id)
    transaction.update(category: category)

    Sidekiq.redis do |conn|
      conn.publish("categorisation", "success")
    end
  end
end

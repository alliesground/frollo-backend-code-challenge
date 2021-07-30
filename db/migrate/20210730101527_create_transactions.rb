class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :posted_date
      t.string :currency
      t.decimal :amount
      t.text :description, limit: 300
      t.string :type
    end
  end
end

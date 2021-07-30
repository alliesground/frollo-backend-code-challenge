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
end

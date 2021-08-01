FactoryBot.define do
  factory :transaction do
    posted_date { "2021-01-01" }
    currency { "AUD" }
    amount { 100 }
    description { "This is a test" }
    type { "OTHER" }
    category { nil }

    factory :invalid_transaction do
      currency { "INVALID" }
    end
  end
end

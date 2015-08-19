FactoryGirl.define do
  factory :price do
    price 120
    start_date 6.month.ago
    end_date 6.month.since
    product
  end

  factory :old_price, class: Price do
    price 120
    start_date 6.month.ago
    end_date 1.month.ago
    product
  end

end

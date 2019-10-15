FactoryBot.define do
  factory :vehicle do
    color { 'pink' }
    location { [20, 30] }
    status { 'available' }
  end
end

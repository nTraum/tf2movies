FactoryGirl.define do
  factory :download do
    sequence(:url, "http://example.com/a")
    movie
  end
end

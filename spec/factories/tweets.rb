FactoryGirl.define do
  factory :tweet do
    twitter_id '12345'
    author 'forakerlabs'
    tweet 'Bananas are superior to apples.'
    published_at Time.now
  end
end

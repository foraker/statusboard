class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :twitter_id
      t.datetime :published_at
      t.string :author
      t.text :tweet
      t.string :image_url
      t.string :tweet_url
      t.timestamps null: false
    end
  end
end

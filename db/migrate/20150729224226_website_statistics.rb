class WebsiteStatistics < ActiveRecord::Migration
  def change
    create_table :website_analytics do |t|
      t.date       :date
      t.integer    :visitors
      t.integer    :pageviews
      t.integer    :sessions
      t.timestamps null: false
    end
  end
end

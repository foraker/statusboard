class ForakerStatistics < ActiveRecord::Migration
  def change
    create_table :foraker_statistics do |t|
      t.date       :date
      t.integer    :visitors
      t.integer    :pageviews
      t.integer    :sessions
      t.timestamps null: false
    end
  end
end

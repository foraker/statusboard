class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :words
      t.string :user
      t.timestamp :announced_at

      t.timestamps null: false
    end
  end
end

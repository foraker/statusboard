class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.string :github_id
      t.string :repository
      t.string :title
      t.string :author
      t.integer :size
      t.integer :thumbs
      t.datetime :published_at
      t.string :url
    end
  end
end

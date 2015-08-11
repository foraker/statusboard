class CreatePivotalStories < ActiveRecord::Migration
  def change
    create_table :pivotal_stories do |t|
      t.integer :pivotal_id
      t.integer :project_id
      t.datetime :started_at
      t.datetime :accepted_at
      t.string :url
      t.integer :estimate
      t.text :name
      t.text :description
      t.string :kind
      t.string :story_type
      t.text :labels
      t.string :current_state
      t.text :tags, array: true, default: []
    end
    add_index :pivotal_stories, :project_id
  end
end

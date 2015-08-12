class CreatePivotalEpicStories < ActiveRecord::Migration
  def change
    create_table :pivotal_epic_stories do |t|
      t.integer :story_id
      t.integer :epic_id
      t.datetime :updated_at
      t.datetime :created_at
    end
    add_index :pivotal_epic_stories, :story_id
    add_index :pivotal_epic_stories, :epic_id
  end
end

class AddStoryToGroupConnectionTable < ActiveRecord::Migration

  def self.up
    create_table :story_to_group_connections do |t|
      t.integer   :group_id
      t.integer   :story_id
    end
  end

  def self.down
    drop_table :story_to_group_connection
  end

end

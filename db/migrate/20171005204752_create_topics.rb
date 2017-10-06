class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :community_id
      t.timestamps
    end
  end
end

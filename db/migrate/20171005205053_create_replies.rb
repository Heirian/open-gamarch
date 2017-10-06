class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.text :description
      t.integer :user_id
      t.integer :topic_id
      t.timestamps
    end
  end
end

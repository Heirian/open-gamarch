class CreateCommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :communities do |t|
      t.string :name
      t.text :description
      t.string :website
      t.integer :user_id

      t.timestamps
    end
  end
end

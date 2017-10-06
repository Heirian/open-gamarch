class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.date :release
      t.string :website

      t.timestamps
    end
  end
end

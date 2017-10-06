class CreateDevelopers < ActiveRecord::Migration[5.1]
  def change
    create_table :developers do |t|
      t.string :name
      t.text :description
      t.string :headquarters
      t.date :founded
      t.string :website

      t.timestamps
    end
  end
end

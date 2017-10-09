class AddGameIdToCommunities < ActiveRecord::Migration[5.1]
  def change
    add_column :communities, :game_id, :integer
  end
end

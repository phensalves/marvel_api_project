class AddMarvelIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :marvel_id, :integer
  end
end

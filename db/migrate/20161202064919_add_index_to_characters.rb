class AddIndexToCharacters < ActiveRecord::Migration
  def change
    add_index :characters, :name, unique: true
  end
end

class AddSlugToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :slug, :string
  end
end

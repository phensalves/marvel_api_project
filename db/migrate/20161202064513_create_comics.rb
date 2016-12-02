class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.integer :cover_number
      t.string :image
      t.references :character, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.string :guid, null: false

      t.timestamps
    end

    add_index :songs, :guid, :unique => true
  end
end

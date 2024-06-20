class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end

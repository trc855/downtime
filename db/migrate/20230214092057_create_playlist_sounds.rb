class CreatePlaylistSounds < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_sounds do |t|
      t.references :sound, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end

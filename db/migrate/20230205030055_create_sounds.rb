class CreateSounds < ActiveRecord::Migration[7.0]
  def change
    create_table :sounds do |t|
      t.string :title
      t.string :location
      t.decimal :latitude
      t.decimal :longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

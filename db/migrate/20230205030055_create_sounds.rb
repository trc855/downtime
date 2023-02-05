class CreateSounds < ActiveRecord::Migration[7.0]
  def change
    create_table :sounds do |t|
      t.string :title
      t.decimal :lat
      t.decimal :long
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

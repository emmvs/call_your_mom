class CreateContactMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_media do |t|
      t.integer :rank
      t.references :contact, null: false, foreign_key: true
      t.references :medium, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :text
      t.references :interaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end

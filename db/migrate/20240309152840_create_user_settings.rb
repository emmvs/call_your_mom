class CreateUserSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_settings do |t|
      t.string :preferred_languages
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

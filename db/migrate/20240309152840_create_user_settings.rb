class CreateUserSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_settings do |t|
      t.string :preferred_language, default: 'en'
      t.string :time_zone, default: 'Europe/Berlin'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

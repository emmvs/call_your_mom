class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :relationship, default: "friend"
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :social_media_handle, default: "@ig_name"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

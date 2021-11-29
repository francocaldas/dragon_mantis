class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :social_name
      t.timestamp :birth_date
      t.string :formation
      t.text :description
      t.text :experience
      t.string :photo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

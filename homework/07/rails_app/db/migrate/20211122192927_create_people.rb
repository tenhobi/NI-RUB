class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.string :username, null: false
      t.references :school, null: true, foreign_key: true

      t.timestamps
    end
  end
end

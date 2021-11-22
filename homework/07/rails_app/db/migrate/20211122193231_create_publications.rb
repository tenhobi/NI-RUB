class CreatePublications < ActiveRecord::Migration[6.1]
  def change
    create_table :publications do |t|
      t.string :title, null: false
      t.datetime :published_at, null: true
      t.string :abstract, null: true
      t.references :author, null: false, foreign_key: { to_table: :people }

      t.timestamps
    end
  end
end

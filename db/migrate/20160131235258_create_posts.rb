class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :parent_id
      t.boolean :published
      t.integer :level
      t.string :title
      t.string :body

      t.timestamps null: false
    end
    add_index(:posts, :parent_id, {})
    add_foreign_key(:posts, :posts, column: :parent_id)
  end
end

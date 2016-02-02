class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :up, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.references :post, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end

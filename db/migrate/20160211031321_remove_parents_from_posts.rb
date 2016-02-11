class RemoveParentsFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :parent_id
  end
end

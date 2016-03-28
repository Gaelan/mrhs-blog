class AddPostToScore < ActiveRecord::Migration[5.0]
  def up
    add_column :scores, :post_id, :integer

    Score.find_each do |score|
      if Post.where(user: score.user, assessment: score.assessment).count == 1
        score.update(
          post_id: Post.where(user: score.user, assessment: score.assessment)[0].id
        )
      end
    end
  end

  def down
    remove_column :scores, :post_id, :integer
  end
end

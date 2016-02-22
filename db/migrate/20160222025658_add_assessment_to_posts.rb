class AddAssessmentToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :assessment, foreign_key: true
  end
end

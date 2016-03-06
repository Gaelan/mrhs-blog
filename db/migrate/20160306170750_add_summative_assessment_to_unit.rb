class AddSummativeAssessmentToUnit < ActiveRecord::Migration[5.0]
  def change
    add_column :units, :summative_assessment, :integer
  end
end

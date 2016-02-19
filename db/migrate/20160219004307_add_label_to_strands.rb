class AddLabelToStrands < ActiveRecord::Migration[5.0]
  def change
    add_column :strands, :label, :string
  end
end

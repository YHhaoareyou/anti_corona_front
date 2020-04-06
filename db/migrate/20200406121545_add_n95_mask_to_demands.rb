class AddN95MaskToDemands < ActiveRecord::Migration[6.0]
  def change
    add_column :demands, :n95_mask, :integer, :after => :medical_mask
    rename_column :demands, :mask, :cloth_mask
    add_column :supplies, :n95_mask, :integer, :after => :medical_mask
    rename_column :supplies, :mask, :cloth_mask
  end
end

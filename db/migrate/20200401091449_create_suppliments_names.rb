class CreateSupplimentsNames < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliments_names do |t|
      t.string :key
      t.string :english
      t.string :japanese
      t.string :zh_chinese
      t.string :sp_chinese

      t.timestamps
    end
  end
end

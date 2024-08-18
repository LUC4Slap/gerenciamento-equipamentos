class CreateEquipamentos < ActiveRecord::Migration[7.1]
  def change
    create_table :equipamentos do |t|

      t.timestamps
    end
  end
end

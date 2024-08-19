class AddNomeAndQuantidadeToEquipamentos < ActiveRecord::Migration[7.1]
  def change
    add_column :equipamentos, :nome, :string
    add_column :equipamentos, :quantidade, :integer
  end
end

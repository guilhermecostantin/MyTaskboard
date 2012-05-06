class AddColumnToProjetos < ActiveRecord::Migration
  def change
    add_column :projetos, :usuario_id, :string
  end
end

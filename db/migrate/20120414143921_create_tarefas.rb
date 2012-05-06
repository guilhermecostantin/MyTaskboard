class CreateTarefas < ActiveRecord::Migration
  def change
    create_table :tarefas do |t|
      t.text :descricao
      t.string :etapa
      t.string :projeto_id

      t.timestamps
    end
  end
end

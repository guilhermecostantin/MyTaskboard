class CreateProjetos < ActiveRecord::Migration
  def change
    create_table :projetos do |t|
      t.string :nome
      t.string :nome_responsavel
      t.string :email_responsavel

      t.timestamps
    end
  end
end

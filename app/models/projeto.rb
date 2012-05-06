class Projeto
  include MongoMapper::EmbeddedDocument
  key :nome, String
  key :nome_responsavel, String
  key :email_responsavel, String
 # key :tarefas, Hash, :default => {'descricao' => 'Digite aqui a descrição de sua tarefas', 'coluna' => 1}
  
  validates :nome, :presence =>true
  validates :usuario_id, :presence =>true

  belongs_to :usuario
end

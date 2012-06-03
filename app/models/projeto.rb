class Projeto
  include MongoMapper::EmbeddedDocument
  key :nome, String
  
  validates :nome, :presence =>true
  validates :usuario_id, :presence =>true

  belongs_to :usuario
  many :tarefas
end

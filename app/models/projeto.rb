class Projeto
  include MongoMapper::Document
  key :nome, String
  key :usuario_id, ObjectId
  
  validates :nome, :presence =>true
  validates :usuario_id, :presence =>true

  belongs_to :usuario
  many :tarefas
end

class Projeto
  include MongoMapper::Document
  key :nome, String
  key :usuario_id, ObjectId
  timestamps!
  validates :nome, :presence =>true
  validates :usuario_id, :presence =>true

  belongs_to :usuario
  many :tarefas
  
  def delete_task id
    t = self.tarefas.find(id)
    self.tarefas.delete(t)
  end
end

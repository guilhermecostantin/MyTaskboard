class Projeto
  include MongoMapper::Document
  key :nome, String
  key :usuario_id, ObjectId
  key :solicitacoes_entrada, Array
  timestamps!
  validates :nome, :presence =>true
  validates :usuario_id, :presence =>true

  belongs_to :usuario
  many :tarefas
  many :burndowns
  
  def delete_task id
    t = self.tarefas.find(id)
    self.tarefas.delete(t)
  end
  def tira_solicitacao id
    self.solicitacoes_entrada.delete(id)
    self.save
  end
  def burndown_atual
    if !self.burndowns.empty?
      @burndown = self.burndowns.last
    else
      return nil
    end
  end
end

class Projeto
  include MongoMapper::Document
  key :nome, String
  key :usuario_id, ObjectId
  key :solicitacoes_entrada, Array
  key :estilo_postit_default, Boolean
  key :estilo_afazer, String
  key :estilo_andamento, String
  key :estilo_prontas, String
  key :publico, Boolean
  timestamps!
  validates :nome, :presence =>true
  validates :usuario_id, :presence =>true

  belongs_to :usuario
  many :tarefas
  many :burndowns
  before_save :defaults

  def defaults
    self.publico = true if self.publico.nil?
    self.estilo_postit_default = true if self.estilo_postit_default.nil?
    self.estilo_afazer = 'postit_default' if self.estilo_afazer.nil?
    self.estilo_andamento = 'postit_default' if self.estilo_andamento.nil?
    self.estilo_prontas = 'postit_default' if self.estilo_prontas.nil?
  end  

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

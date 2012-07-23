class Tarefa
  include MongoMapper::EmbeddedDocument


  key :descricao, String
  key :status, Integer
  timestamps!
  belongs_to :projetos
  
  def change_status string
    case string
      when 'coluna1'
        self.status = 1
      when 'coluna2'
        self.status = 2
      when 'coluna3'
        self.status = 3
    end
  end

end

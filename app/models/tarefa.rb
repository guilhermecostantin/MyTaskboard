class Tarefa
  include MongoMapper::EmbeddedDocument


  key :descricao, String
  key :status, Integer

  belongs_to :projetos

end

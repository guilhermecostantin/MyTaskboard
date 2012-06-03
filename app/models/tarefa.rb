class Tarefa
  include MongoMapper::EmbeddedDocument


  key :descricao, String
  key :status, Int

  belongs_to :projetos

end

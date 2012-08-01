class Burndown
  include MongoMapper::EmbeddedDocument


  key :data_inicio, Time
  key :data_fim, Time
  key :duracao, Integer
  key :pontuacao_inicial, Integer
  key :pontos, Array
  
  
  timestamps!
  belongs_to :projetos
  
  
end

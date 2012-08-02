class Burndown
  include MongoMapper::Document

  key :projeto_id
  key :data_inicio, Time
  key :data_fim, Time
  key :duracao, Integer
  key :pontuacao_inicial, Integer
  key :pontos, Array
  
  
  timestamps!
  
  
end

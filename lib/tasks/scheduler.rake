﻿task :atualiza_burndown => :environment do
 b = Burndown.all
  b.each do |burn|
    projeto = Projeto.find(burn.projeto_id)
    if projeto
      pontos = (projeto.tarefas.select{|x| x.status == 1}.count*2) + (projeto.tarefas.select{|x| x.status == 2}.count)
      burn.pontos << pontos
      burn.save
    else
      burn.destroy
    end
  end
end

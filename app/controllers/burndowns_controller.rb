class BurndownsController < ApplicationController
 before_filter {@projeto = Projeto.find(params[:projeto_id])}
 before_filter{@solicitacoes = @projeto.solicitacoes_entrada}

  def index
    @burndown = Burndown.find_by_projeto_id(params[:projeto_id])
    if !@burndown.nil?
      @array = @burndown.pontos
      @razao = @burndown.pontuacao_inicial/@burndown.duracao.to_f
      @pontuacao_inicial = @burndown.pontuacao_inicial
      @duracao = @burndown.duracao
    end
  end
  
  def create
    hash = Hash.new
    hash[:projeto_id] = params[:projeto_id]  
    hash[:pontuacao_inicial] = (@projeto.tarefas.select{|x| x.status == 1}.count*2) + (@projeto.tarefas.select{|x| x.status == 2}.count)
    
    hash[:data_inicio] = Date.strptime(params[:data_inicio],"%d/%m/%Y")
    hash[:data_fim] = Date.strptime(params[:data_fim],"%d/%m/%Y")
    hash[:duracao] = (hash[:data_fim] - hash[:data_inicio]).to_i + 1
    hash[:pontos] = Array.new
    hash[:pontos] << hash[:pontuacao_inicial]
    burn = Burndown.new(hash) 
    respond_to do |format|
      if burn.save
        format.html { redirect_to projeto_burndowns_path(@projeto), notice: 'O Burndown foi criado com sucesso.' }
        format.json { render json: burn, status: :created, location: burn }
      else
        flash[:error] = "Ocorreu um erro e o burndown nao pode ser criado, tente novamente mais tarde"
        redirect_to projeto_path(@projeto)
      end
    end
   end
  
  def destroy
    @burndown = Burndown.find_by_projeto_id(params[:projeto_id])
    respond_to do |format|
      if @burndown.destroy
        format.html { redirect_to projeto_burndowns_path(@projeto)}
      else
        flash[:error] = "Ocorreu um erro e o burndown nao pode ser criado, tente novamente mais tarde"
        redirect_to projeto_path(@projeto)
      end
      end
  end
end

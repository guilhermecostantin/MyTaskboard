class BurndownsController < ApplicationController
 
  def index
    @projeto = Projeto.find(params[:projeto_id])
    @burndown = @projeto.burndown_atual
    if !@burndown.nil?
      @array = @burndown.pontos
      @razao = @burndown.pontuacao_inicial/@burndown.duracao.to_f
      @pontuacao_inicial = @burndown.pontuacao_inicial
      @duracao = @burndown.duracao
    end
  end
  
  def create
    hash = Hash.new
    @projeto = Projeto.find(params[:projeto_id])  
    hash[:pontuacao_inicial] = @projeto.tarefas.select{|x| x.status == 1}.count*2
    hash[:data_inicio] = Date.strptime(params[:data_inicio],"%m/%d/%Y")
    hash[:data_fim] = Date.strptime(params[:data_fim],"%m/%d/%Y")
    hash[:duracao] = (hash[:data_fim] - hash[:data_inicio]).to_i + 1
    hash[:pontos] = Array.new
    hash[:pontos] << hash[:pontuacao_inicial]
    # razao = hash[:pontuacao_inicial]/hash[:duracao].to_f
    # total = hash[:pontuacao_inicial]
    # pontos = Array.new
    # pontos << ['Dia', 'Ideal', 'Real']
    # hash[:duracao].times do |n|
      # if n == 0
        # pontos << [n,total, total]  
      # elsif n == hash[:duracao]-1
        # pontos << [n,0, :null]
      # else
        # pontos << [n,total, :null]
      # end
      # total -=razao
    # end
    # hash[:pontos] = pontos
    burn = Burndown.new(hash) 
   @projeto.burndowns << burn
   @projeto.save
   end

end

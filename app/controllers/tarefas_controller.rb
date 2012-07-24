class TarefasController < ApplicationController
 
  def create
    @projeto = Projeto.find(params[:projeto_id])    
    @array = params[:descricao].split("\r\n")
    @array.each do |t|
      @tarefa = Tarefa.new(:descricao => t, :status => 1)
      @projeto.tarefas << @tarefa
    end
    respond_to do |format|
      if @projeto.save
        format.html { redirect_to @projeto, notice: 'As tarefas foram criadas com sucesso' }
        format.json { render json: @projeto, status: :created, location: @projeto}
      else
        format.html { redirect_to @projeto, notice: 'Problemas ao criar as tarefas, tente novamente mais tarde.' }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @projeto = Projeto.find(params[:projeto_id])
    @projeto.delete_task(params[:id])
    if @projeto.save
      head 200
     else
       head :bad_request
     end
  end
  
  def muda_status
    @projeto = Projeto.find(params[:projeto_id])
    @tarefa = @projeto.tarefas.find(params[:id])
    @tarefa.change_status params[:coluna]
   if @projeto.save
      head :ok
    else
      respond_to do |format|
        format.html 
        format.json { render json: @projeto.errors, status: :unprocessable_entity  }
      end
   end
  end
  
end

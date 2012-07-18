class TarefasController < ApplicationController
  # GET /tarefas
  # GET /tarefas.json
  before_filter :authenticate_usuario!
  before_filter {@usuario = current_usuario}
  
  #vai ficar no controller das tarefas
  def index
    @projeto = @usuario.projetos.find(params[:projeto_id])
    @tarefas = @projeto.tarefas
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarefas }
      format.json { render json: @projetos }
    end
  end

  #nao vai ter show
  #GET /tarefas/1
  #GET /tarefas/1.json
  def show
    @projeto = @usuario.projetos.find(params[:projeto_id])
    @tarefa = @projeto.tarefas.find(params[:tarefa_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarefa }
    end
  end

  # GET /tarefas/new
  # GET /tarefas/new.json
  def new
    @tarefa = Tarefa.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarefa }
    end
  end

  # GET /tarefas/1/edit
  def edit
    @projeto = @usuario.projetos.find(params[:projeto_id])
    @tarefa = @projeto.tarefas.find(params[:tarefa_id])
  end

  # POST /tarefas
  # POST /tarefas.json
  def create
    
    @projeto = @usuario.projetos.find(params[:projeto_id])    
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

  # PUT /tarefas/1
  # PUT /tarefas/1.json
  def update
    
    @projeto = @usuario.projetos.find(params[:projeto_id])
    @tarefa = @projeto.tarefas.find(params[:tarefa_id])

    respond_to do |format|
      if @tarefa.update_attributes(params[:tarefa])
        format.html { redirect_to @tarefa, notice: 'Tarefa was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarefa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarefas/1
  # DELETE /tarefas/1.json
  def destroy
    @projeto = @usuario.projetos.find(params[:projeto_id])
    t = @projeto.tarefas.find(params[:id])
    @projeto.tarefas.delete(t)
    @projeto.save

    respond_to do |format|
      format.html { redirect_to @projeto }
      format.json { head :ok }
    end
  end
  
  def muda_status
    @projeto = @usuario.projetos.find(params[:projeto_id])
    @tarefa = @projeto.tarefas.find(params[:id])
    
    case params[:coluna]
    when 'coluna1'
      @tarefa.status = 1
    when 'coluna2'
      @tarefa.status = 2
    when 'coluna3'
      @tarefa.status = 3
    end
   if @projeto.save
      respond_to do |format|
        format.html 
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html 
        format.json { render json: @projeto.errors }
      end
   end
  end
  
  
  
end

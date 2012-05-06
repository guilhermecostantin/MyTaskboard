class ProjetosController < ApplicationController
  # GET /projetos
  # GET /projetos.json
  before_filter :authenticate_usuario!
  before_filter {@usuario = current_usuario}
  
  def index
    
    @projetos = @usuario.projetos
    @usuario_logado = usuario_signed_in?
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projetos }
    end
  end

  # GET /projetos/1
  # GET /projetos/1.json
  def show
    
    @projeto = @usuario.projetos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @projeto }
    end
  end

  # GET /projetos/new
  # GET /projetos/new.json
  def new
    @projeto = Projeto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @projeto }
    end
  end

  # GET /projetos/1/edit
  def edit
    @projeto = Projeto.find(params[:id])
  end

  # POST /projetos
  # POST /projetos.json
  def create
    
    @projeto = Projeto.new(params[:projeto])
    @usuario.projetos << @projeto
    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @projeto, notice: 'Projeto was successfully created.' }
        format.json { render json: @projeto, status: :created, location: @projeto }
      else
        format.html { render action: "new" }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projetos/1
  # PUT /projetos/1.json
  def update
    @projeto = Projeto.find(params[:id])

    respond_to do |format|
      if @projeto.update_attributes(params[:projeto])
        format.html { redirect_to @projeto, notice: 'Projeto was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projetos/1
  # DELETE /projetos/1.json
  def destroy
    @projeto = Projeto.find(params[:id])
    @projeto.destroy

    respond_to do |format|
      format.html { redirect_to projetos_url }
      format.json { head :ok }
    end
  end
  
  def criar_tarefa
    @tarefa = Tarefa.new
    @tarefa.projeto_id = params[:projeto_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarefa }
    end
  end
  
  def create_tarefa
    @tarefa = Tarefa.new(params[:tarefa])
    @tarefa.projeto_id = params[:projeto_id]
    respond_to do |format|
      if @tarefa.save
        format.html { redirect_to @tarefa, notice: 'Tarefa was successfully created.' }
        format.json { render json: @tarefa, status: :created, location: @tarefa }
      else
        format.html { render action: "new" }
        format.json { render json: @tarefa.errors, status: :unprocessable_entity }
      end
    end
  end
  
end

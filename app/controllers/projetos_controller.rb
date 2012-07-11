class ProjetosController < ApplicationController
  # GET /projetos
  # GET /projetos.json
  before_filter :authenticate_usuario!
  before_filter {@usuario = current_usuario}
  
  def index
    @novo_projeto = Projeto.new    
    @projetos = @usuario.projetos
    if !@usuario.permissoes_projetos.empty?
      @permitidos = Array.new
      @usuario.permissoes_projetos.each do |pp|
        @permitidos << Projeto.find(pp)
      end
    end
    @usuario_logado = usuario_signed_in?
    
  end

  def create
    
    @projeto = Projeto.new(params[:projeto])
    
    respond_to do |format|
      if @projeto.save
        #trocar esses redirects aqui
        format.html { redirect_to @projeto, notice: 'Projeto was successfully created.' }
        format.json { render json: @projeto, status: :created, location: @projeto }
      else
        format.html { render action: "new" }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @users = Usuario.all
    @projeto = @usuario.projetos.find(params[:id])
    @tarefas = @projeto.tarefas
    @afazer = @tarefas.select{|x| x.status==1}
    @andamento = @tarefas.select{|x| x.status==2}
    @prontas = @tarefas.select{|x| x.status==3}
    respond_to do |format|
      format.html 
      format.json { render json: @users}
    end
  end

   # DELETE /projetos/1
  # DELETE /projetos/1.json
  def destroy
    @usuario.projetos(params[:id]).remove()
    
    respond_to do |format|
      format.html { redirect_to projetos_url }
      format.json { head :ok }
    end
  end
  
  def adduser
    ids = params[:users_id].split(",")
    ids.each do |id|
      u = Usuario.find(id)
      u.permissoes_projetos << params[:id]
      u.save
    end
    respond_to do |format|
      format.html { redirect_to projetos_url }
    end
  end
 
  
end

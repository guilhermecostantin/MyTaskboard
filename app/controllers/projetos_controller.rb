class ProjetosController < ApplicationController
  
  def index
    @novo_projeto = Projeto.new    
    @projetos = @usuario.projetos
    @permitidos = @usuario.projetos_permitidos
  end

  def create
    @projeto = Projeto.new(params[:projeto])
    respond_to do |format|
      if @projeto.save
        format.html { redirect_to @projeto, notice: 'O projeto foi criado com sucesso.' }
        format.json { render json: @projeto, status: :created, location: @projeto }
      else
        flash[:error] = "Ocorreu um erro e o projeto nao pode ser salvo, tente novamente mais tarde"
        redirect_to projetos_path
      end
    end
  end
  
  def show
    @users = Usuario.all
    @projeto = Projeto.find(params[:id])
    @tarefas = @projeto.tarefas
    @afazer = @tarefas.select{|x| x.status==1}
    @andamento = @tarefas.select{|x| x.status==2}
    @prontas = @tarefas.select{|x| x.status==3}
    respond_to do |format|
      format.html 
      format.json { render json: @users}
    end
  end

  def destroy
    permissao = @usuario.verifica_permissao params[:id]
    if permissao
      Projeto.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to projetos_url, notice: "Projeto deletado com sucesso" }
        format.json { head :ok }
      end
    else
      #falta exibir para o usuario
      raise SecurityError, "Apenas o dono do projeto pode excluir esse projeto"
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
      format.html { redirect_to :back }
    end
  end
 
 def lista
   @projetos = Projeto.where(:nome=> /#{params[:q]}/).fields(:id, :nome)
    respond_to do |format|
      format.json{ render :json => @projetos }
    end
 end
  
end

# -*- encoding : utf-8 -*-
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
    @solicitacoes = @projeto.solicitacoes_entrada
    @tarefas = @projeto.tarefas
    @afazer = @tarefas.select{|x| x.status==1}
    @andamento = @tarefas.select{|x| x.status==2}
    @prontas = @tarefas.select{|x| x.status==3}
    default = @projeto.estilo_postit_default
    if !default.nil? and default == false
      @estilo_afazer = @projeto.estilo_afazer
      @estilo_andamento = @projeto.estilo_andamento
      @estilo_prontas = @projeto.estilo_prontas
    else
      @estilo_afazer = @estilo_andamento = @estilo_prontas = "postit_default"
    end
    respond_to do |format|
      format.html 
      format.json { render json: @users}
    end
  end
  
  def update
     @projeto = Projeto.find(params[:id])
     respond_to do |format|
        if @projeto.update_attributes(params[:projeto])
          format.html { redirect_to @projeto, notice: 'O projeto foi atualizado com sucesso.' }
          format.json { render json: @projeto, status: :created, location: @projeto }
        else
          flash[:error] = "Ocorreu um erro e o projeto nao pode ser salvo, tente novamente mais tarde"
          redirect_to projetos_path
        end
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
      @usuario.permissoes_projetos.delete(params[:id])
      if @usuario.save
      respond_to do |format|
        format.html { redirect_to projetos_url, notice: "Projeto removido com sucesso" }
        format.json { head :ok }
      end
      else
        respond_to do |format|
        format.html { redirect_to projetos_url, notice: "Ocorreu um erro ao salvar, tente novamente mais tarde." }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
      end
    end
  end
  
  def adduser
    ids = params[:users_id].split(",")
    ids.each do |id|
      u = Usuario.find(id)
      u.permissoes_projetos << params[:id] unless u.permissoes_projetos.include?(params[:id])
      u.save
    end
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
 
 def solicitacoes
  @projeto = Projeto.find(params[:id])
  @solicitacoes = @projeto.solicitacoes_entrada
  @usuarios = Array.new
  @solicitacoes.each do |id|
    @usuarios << Usuario.find(id)
  end  
 end
 
 def lista
   @projetos = Projeto.where(:publico => true, :usuario_id.ne => @usuario.id, :nome=> /#{params[:q]}/i).fields(:id, :nome)
    respond_to do |format|
      format.json{ render :json => @projetos }
    end
 end

 def destroy_tarefas
    @projeto = Projeto.find(params[:id])
    #@projeto.delete_varias_task(params[:coluna])
   # @projeto.tarefas.delete_if{|x| x.status == params[:coluna]}
   t = @projeto.tarefas.select{|x| x.status == params[:coluna]}
   t.each do |tarefa|
    tarefa.destroy
   end
    
    if @projeto.save
      respond_to do |format|
        format.html { redirect_to projetos_url, notice: "Tarefas deletadas com sucesso" }
        format.json { head :ok , notice: "Tarefas deletadas com sucesso"}
      end
    else
      respond_to do |format|
        format.html { redirect_to projetos_url, notice: "Ocorreu um erro ao salvar, tente novamente mais tarde." }
        format.json { render json: @projeto.errors, status: :unprocessable_entity, notice: "Tarefas deletadas com sucessoooo" }
      end
    end
  end

end

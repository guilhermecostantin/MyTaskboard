class ProjetosController < ApplicationController
  # GET /projetos
  # GET /projetos.json
  before_filter :authenticate_usuario!
  before_filter {@usuario = current_usuario}
  
  def index
    @novo_projeto = Projeto.new    
    @projetos = @usuario.projetos
    @usuario_logado = usuario_signed_in?
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projetos}
      format.json { render json: @novo_projeto}
    end
  end

  def create
    
    @projeto = Projeto.new(params[:projeto])
    @usuario.projetos << @projeto
    respond_to do |format|
      if @usuario.save
        #trocar esses redirects aqui
        format.html { redirect_to @projeto, notice: 'Projeto was successfully created.' }
        format.json { render json: @projeto, status: :created, location: @projeto }
      else
        format.html { render action: "new" }
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
 
  
end

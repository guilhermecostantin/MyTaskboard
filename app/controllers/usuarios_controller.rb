class UsuariosController < ApplicationController
  # GET /projetos
  # GET /projetos.json
  before_filter :authenticate_usuario!
  before_filter {@usuario = current_usuario}
  
  def index
    @usuarios = Usuario.where(:id.ne => @usuario.id, :email=> /#{params[:q]}/)
    respond_to do |format|
      format.json{ render :json => @usuarios }
    end
  end

 def addproject
   ids = params[:projetos_id].split(",")
   ids.each do |id|
     projeto = Projeto.find(id)
     projeto.solicitacoes_entrada << @usuario.id
     projeto.save
   end
   respond_to do |format|
      format.html { redirect_to projetos_url, notice: "solicitacao enviada aos donos do projeto" }
    end
   
   
   # ids = params[:projetos_id].split(",")
   # ids.each do |id|
     # @usuario.permissoes_projetos << id
   # end
   # @usuario.save
   # respond_to do |format|
      # format.html { redirect_to projetos_url }
    # end
 end
 
  
end

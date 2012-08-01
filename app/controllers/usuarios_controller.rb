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
     if !@usuario.permissoes_projetos.include?(id)
       projeto = Projeto.find(id)
       projeto.solicitacoes_entrada << @usuario.id
       projeto.save
     end
   end
   respond_to do |format|
      format.html { redirect_to projetos_url, notice: "solicitacao enviada aos donos do projeto" }
    end
 end
 
 def aceitaProjeto
   usuario = Usuario.find(params[:id])
   projeto = Projeto.find(params[:projeto_id])
   usuario.inclui_projeto params[:projeto_id]
   projeto.tira_solicitacao usuario.id
   respond_to do |format|
      format.html { redirect_to projeto_path(projeto), notice: "deu certo brow" }
   end
 end
  
end

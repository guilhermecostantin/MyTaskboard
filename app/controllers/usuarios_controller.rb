class UsuariosController < ApplicationController
  # GET /projetos
  # GET /projetos.json
  before_filter :authenticate_usuario!
  before_filter {@usuario = current_usuario}
  
  def index
    @usuarios = Usuario.where(:email=> /#{params[:q]}/)
    respond_to do |format|
      format.json{ render :json => @usuarios }
    end
  end

 
 
  
end

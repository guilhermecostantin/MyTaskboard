class SiteController < ActionController::Base
  # GET /projetos
  # GET /projetos.json
  layout "application"
  def index
  	render :layout => "site"
  end

  def home

  end
 

  
end

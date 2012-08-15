class ApplicationController < ActionController::Base
  
  before_filter :authenticate_usuario!
  before_filter {@usuario = current_usuario}
  
  def after_sign_in_path_for(resource)
     projetos_path
  end
  
  def after_sign_out_path_for(resource)
     root_path
  end
  def after_sign_up_fails_path_for(resource)
     root_path
  end
   
  
  protect_from_forgery
  

end

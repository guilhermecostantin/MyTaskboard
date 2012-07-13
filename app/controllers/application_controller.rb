class ApplicationController < ActionController::Base
  
  protect_from_forgery
  def after_sign_up_path_for(resource)
     stored_location_for(resource) || '/projetos'
  end

end

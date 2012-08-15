# -*- encoding : utf-8 -*-
class Usuario
  include MongoMapper::Document
  devise :database_authenticatable, :registerable
  
  key :nome, String
  key :email, String
  key :permissoes_projetos, Array
  key :encrypted_password, String
  key :current_sign_in_at, Time
  
  key :password_salt, String
  key :reset_password_token, String
  key :remember_token, String
  key :remember_created_at, Time
  key :sign_in_count, Integer
  key :last_sign_in_at, Time

  timestamps!
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'Formato de email inválido'
  validates_presence_of :password, :message => 'Senha não pode estar em branco'
  validates_uniqueness_of :email, :message => 'Email já está em uso'
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  many :projetos
  
  def projetos_permitidos
    permitidos = Array.new
      if !self.permissoes_projetos.empty?
        self.permissoes_projetos.each do |id_projeto|
          projeto = Projeto.find(id_projeto)
          if projeto.nil?
            self.limpa_permissoes id_projeto
          else
            permitidos << projeto  
          end
        end
      end
     return permitidos
  end
  
  def limpa_permissoes id_projeto
    self.permissoes_projetos.delete(id_projeto)
    self.save
  end
  
  def verifica_permissao projeto_id
    owner_id = Projeto.find(projeto_id).usuario_id
    if self.id == owner_id
      return true
    else
      return false
    end
  end
  
  def inclui_projeto id
    self.permissoes_projetos << id
    self.save
  end
  
end

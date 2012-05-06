class Usuario
  include MongoMapper::Document
  devise :database_authenticatable, :registerable,
         :validatable
  
  key :nome, String
  key :email, String
  key :encrypted_password, String
  key :current_sign_in_at, Time
  
  key :username,  String
  key :comment_count, Integer
  
  key :password_salt, String
  key :reset_password_token, String
  key :remember_token, String
  key :remember_created_at, Time
  key :sign_in_count, Integer
  key :last_sign_in_at, Time


  timestamps!
  
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  many :projetos
end

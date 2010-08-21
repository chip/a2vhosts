class VirtualHost
  include DataMapper::Resource

  property :id,             Serial
  property :name,           String  
  property :server_name,    String  
  property :document_root,  String
  property :rails_env,      String  
  property :created_at,     DateTime
  property :updated_at,     DateTime

  #validates_present :name, :server_name, :document_root
end

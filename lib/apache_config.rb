class ApacheConfig
  include DataMapper::Resource

  property :id,                 Serial
  property :virtual_hosts_path, String  
  property :apachectl,          String
  property :created_at,         DateTime
  property :updated_at,         DateTime

  #validates_present :virtual_hosts_path, :apachectl
end

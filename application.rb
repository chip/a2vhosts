require 'rubygems'
require 'sinatra'
require 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

helpers Sinatra::Partials

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  @virtual_hosts = VirtualHost.all
  haml :root
end

get '/new' do
  haml :new
end

post '/create' do
  @virtual_host = VirtualHost.new(params[:virtual_host])
  if @virtual_host.save
    redirect '/'
  else
    #@virtual_host.inspect
    redirect '/new'
  end
end

get '/apache_config/edit' do
  haml :apache_config_edit
end

put '/apache_config/update' do
  haml :apache_config_update
end
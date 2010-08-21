require 'rubygems'
require 'sinatra'
require "sinatra/reloader" #if development?
require 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

configure :development do
  # Create or upgrade all tables at once, like magic
  DataMapper.auto_upgrade!
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
  haml :"virtual_hosts/index"
end

get '/new' do
  haml :"virtual_hosts/new"
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

get '/delete/:id' do
  @virtual_host = VirtualHost.get(params[:id])
  @virtual_host.inspect
  # virtual_host.delete unless virtual_host.nil?
  # redirect '/'
end

get '/apache_config/edit' do
  @apache_config = ApacheConfig.first || ApacheConfig.new
  haml :"apache_config/edit"
end

put '/apache_config' do
  @apache_config = ApacheConfig.new(params[:apache_config])
  @apache_config.save
  haml :"apache_config/edit"
end
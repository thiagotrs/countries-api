require 'sinatra'
require "sinatra/json"
require "sinatra/reloader" # if development?

set :port, 8080
set :public_folder, File.join(File.dirname(__FILE__), 'static')

require './routes.rb'

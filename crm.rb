require_relative 'contact'
require 'sinatra'

get ("/") do
  erb :index
end

get ("/about") do
  erb :about
end

get ("/index") do
  @contact_collection = Contact.all
  erb :index
end

after do
  ActiveRecord::Base.connection.close
end

get ("/contacts") do
  @contact_collection = Contact.all
  erb :contacts
end

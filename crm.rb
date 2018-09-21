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

get '/contacts/:id' do
  params[:id]
  @contact = Contact.find_by({id: params[:id].to_i})
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to ("/index")
end

get '/about' do
  erb :about
end

get '/index' do
  @contact_collection = Contact.all
  erb :index
end

after do
  ActiveRecord::Base.connection.close
end

get '/contacts' do
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

get '/new' do
  erb :new_contact
end

post '/contacts' do
  puts params
  Contact.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    note: params[:note]
  )
  redirect to('/contacts')
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

get '/index/search/:first_name' do
  p params[:first_name]
  @contact = Contact.find_by(first_name: params[:first_name])
  if @contact
    erb :edit_contact
  else
    puts "Contact does not exist"
    raise Sinatra::NotFound
  end
end

require 'sinatra'
require_relative 'db_connection'

get '/' do
    item = get_all_items
    categories = get_all_categories
    erb :index, locals: {
        items: item,
        categories: categories
    }
end

get '/items/new' do
    categories = get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/create' do
    name = params['name']
    price = params['price']
    category = params['category']
    insert_item(name,price,category)
    redirect '/'
end


post '/items/update' do
    id = params['id']
    name = params['name']
    price = params['price']
    category = params['category']
    update_items(id,name,price)
    update_items_category(id,category)
    redirect '/'
end

post '/items/delete' do
    id = params['id']
    delete_items_category(id)
    delete_items(id)
    redirect '/'
end
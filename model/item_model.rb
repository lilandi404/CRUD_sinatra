require_relative '../db/db_connection'
require_relative '../item'


def get_all_items
    client = create_db_client
    rawData = client.query("select items.id, items.name, items.price, categories.name As 'categori'
        FROM items
        JOIN item_categories ON items.id = item_categories.item_id
        JOIN categories ON item_categories.category_id = categories.id;")
    items = Array.new
    rawData.each do |data|
        item = Items.new(data["id"], data["name"], data["price"], data["categori"])
        items.push(item)
    end
    items
end

def insert_item(name, price, category)
    client = create_db_client
    res_query = client.query("INSERT INTO items (name, price) VALUES ('#{name}', '#{price}')")
    search_id(name, category)
end

def search_id(name,category)
    client = create_db_client
    rawData = client.query("select items.id from items where name='#{name}'")
    id = Array.new
    rawData.each do |raw|
        id = raw["id"]
        id << id
    end
    insert_item_category(id,category)
end

def insert_item_category(id,category)
    client = create_db_client
    res_query = client.query("INSERT INTO item_categories (item_id, category_id) VALUES ('#{id}', '#{category}')")
end

def update_items(id,name,price)
    client = create_db_client
    res_query = client.query("UPDATE items SET name='#{name}', price='#{price}' where id='#{id}'")
    # res_query = client.query("UPDATE item_categories SET category_id='#{category}' where item_id='#{id}'")
end

def update_items_category(id,category)
    category_id = category.to_i
    client = create_db_client
    res_query = client.query("UPDATE item_categories SET category_id='#{category_id}' where item_id='#{id}'")
end

def delete_items_category(id)
    client = create_db_client
    res_query = client.query("DELETE from item_categories where item_id='#{id}'")
end
def delete_items(id)
    client = create_db_client
    res_query = client.query("DELETE from items where id='#{id}'")
end


def get_item_by_id(id)
    client = create_db_client 
    rawData = client.query("select items.id, items.name, items.price, categories.name As 'categori'
        FROM items
        JOIN item_categories ON items.id = item_categories.item_id
        JOIN categories ON item_categories.category_id = categories.id
        WHERE items.id = #{id};")
    items = Array.new
    rawData.each do |data|
        item = Items.new(data["id"], data["name"], data["price"], data["categori"])
        items.push(item)
    end
    items
end

def get_all_items_with_categories
    client = create_db_client
    rawData = client.query("select items.id, items.name, items.price, categories.id As 'categori'
        FROM items
        JOIN item_categories ON items.id = item_categories.item_id
        JOIN categories ON item_categories.category_id = categories.id")
    items = Array.new
    rawData.each do |data|
        category = Category.new(data["id"], data["name"])
        item = Items.new(data["id"], data["name"], data["price"])
        items.push(item)
    end
    items
end 

def get_all_item_by_price
    client = create_db_client
    res_query = client.query("SELECT * FROM items WHERE price > 7000 ")
end
require_relative '../db/db_connection'
require_relative '../category'

def get_all_categories
    client = create_db_client
    rawData = client.query("select * from categories")
    categories = Array.new
    rawData.each do |data|
        category = Category.new(data["id"], data["name"])
        categories.push(category)
    end
    categories
end 
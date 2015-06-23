
require "pry"
require "sinatra"
require "sinatra/reloader"
require "sqlite3"


CONNECTION = SQLite3::Database.new("check.db")

CONNECTION.results_as_hash = true
require_relative "stores.rb"
require_relative "clubcodes.rb"
require_relative "clubs.rb"





CONNECTION.execute("CREATE TABLE IF NOT EXISTS stores (id INTEGER PRIMARY KEY, location VARCHAR(40)); ")

CONNECTION.execute("CREATE TABLE IF NOT EXISTS clubcodes (clubid VARCHAR(5), clubtype VARCHAR(40), brand VARCHAR(40)); ")

CONNECTION.execute("CREATE TABLE IF NOT EXISTS clubs (storeid INTEGER, clubid VARCHAR(5), price FLOAT, quantity INTEGER); ")


#Gives user choice of which function to run
# puts "What would you like to do? "
# puts "(s)ee all stores listed, club codes and clubs in stock?"
# puts "(a)dd a new product? (u)pdate a product's record?"
# puts "(n)ew location? (h)ave new club code to add?"
# puts "(v)iew a certain store's inventory? "
# puts "(c)hange a product's location? (d)elete a product's records?"
# puts "(r)emove a location? (q)uit"



get "/home" do
  erb :"home"
end


get "/add_clubs_form" do
  erb :"add_clubs_form"
end


get "/add_clubs" do
  
  
  club_object = Club.new
  
  
  club_object.add_to_database(params["store_id"].to_i, params["club_id"], params["pri"].to_f, params["quant"].to_i)
  
  erb :"add_clubs"
end


get "/add_clubcodes_form" do
 
  erb :"add_clubcodes_form"
end

get "/add_clubcodes" do
 

  code = params["brand"][0]+params["brand"][1]+params["club_type"][0]
  
  code = code.upcase
  
  object = ClubCode.new
  object.add_to_database(code, params["club_type"], params["brand"])
  
  
  erb :"add_clubcodes"
end

get "/remove_store_form" do
  erb :"remove_store_form"
  
end

get "/remove_store" do
  
  if Store.remove_location(params["store_id"])
    erb :"remove_store"
  else
    erb :"store_remove_fail"
  end
 
  # if result == []
 #    CONNECTION.execute("DELETE FROM stores WHERE id = #{sid};")
 #  else
 #    puts "This location cannot be removed until it has no inventory"
 #  end
  
  
end

get "/single_store" do
  erb :"single_store"
  
end

get "/show_single_store" do
  
  
  @this_store = Club.find(params["store_id"])
  
  erb :"show_single_store"
end


# get "/save_clubs" do
#
#   club_object = Club.new({"storeid" => params["storeid"], "clubid" => params["clubid"], "quantity" => params["quantity"].to_i, "price" => params["price"].to_f})
#   club_object.add
#
#   #still need to add this erb
#   erb :"clubs_added"
# end

get "/add_store_form" do
  erb :"add_store_form"
end

get "/add_store" do
   Store.new_location(params["location"])
  
  erb :"add_store"
end

get "/remove_product_form" do
  
  erb :"remove_product_form"
end

get "/remove_product" do
  Club.delete_record(params["old_store"], params["club_id"])
  
  
  erb :"remove_product"
end







get "/update_location_form" do
  erb :"update_location_form"
end


get "/update_location" do

  
  Club.change_location(params["old_store"].to_i, params["club_id"], params["new_store"].to_i)
  
 erb :"update_location"
  
end


get "/all_stores" do
  erb :"all_stores"
end

get "/all_clubs" do
  erb :"all_clubs"
end


get "/all_clubcodes" do
  erb :"all_clubcodes"
end













require "sinatra"
require "sinatra/reloader"

require "sqlite3"


CONNECTION = SQLite3::Database.new("check.db")

CONNECTION.results_as_hash = true
require_relative "stores.rb"
require_relative "clubcodes.rb"
require_relative "clubs.rb"





CONNECTION.execute("DROP TABLE IF EXISTS stores;")
CONNECTION.execute("DROP TABLE IF EXISTS clubcodes;")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS stores (id INTEGER PRIMARY KEY, location VARCHAR(40)); ")

CONNECTION.execute("CREATE TABLE IF NOT EXISTS clubcodes (clubid VARCHAR(5), clubtype VARCHAR(40), brand VARCHAR(40)); ")

CONNECTION.execute("CREATE TABLE IF NOT EXISTS clubs (storeid INTEGER, clubid VARCHAR(5), price FLOAT, quantity INTEGER); ")

require_relative "database.rb"
#Gives user choice of which function to run
# puts "What would you like to do? "
# puts "(s)ee all stores listed, club codes and clubs in stock?"
# puts "(a)dd a new product? (u)pdate a product's record?"
# puts "(n)ew location? (h)ave new club code to add?"
# puts "(v)iew a certain store's inventory? "
# puts "(c)hange a product's location? (d)elete a product's records?"
# puts "(r)emove a location? (q)uit"

# input = gets.chomp.downcase

get "/home" do
  erb :"home"
end

get "/add_clubs" do
  erb :"add_clubs"
end

get "/save_clubs" do
  
  club_object = Club.new({"storeid" => params["storeid"], "clubid" => params["clubid"], "quantity" => params["quantity"].to_i, "price" => params["price"].to_f})
  club_object.add
  
  #still need to add this erb
  erb :"clubs_added"
end

get "/add_store_form" do
  erb :"add_store_form"
end

get "/add_store" do
   Store.new_location(params["location"])
  
  erb :"add_store"
end



get "/update_location_form" do
  erb :"update_location_form"
end


get "/update_location" do
  Club.change_location(params["oldstoreid"].to_i, params["clubid"], params["storeid"].to_i)
  
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












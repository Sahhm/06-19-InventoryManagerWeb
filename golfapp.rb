
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
puts "What would you like to do? "
puts "(s)ee all stores listed, club codes and clubs in stock?"
puts "(a)dd a new product? (u)pdate a product's record?"
puts "(n)ew location? (h)ave new club code to add?"
puts "(v)iew a certain store's inventory? "
puts "(c)hange a product's location? (d)elete a product's records?"
puts "(r)emove a location? (q)uit"

input = gets.chomp.downcase

#Loop that as long as user does not choose to quit they can keep choosing different
#functions back to back.
while input != "q" do
  
  
  #if user wants to create a new store, prompted for store location then runs new_location
  #method in the Store class
  if input == "n"
    puts "What is the location for the new store?"
    store = gets.chomp.to_s
    Store.new_location(store)
  end
  
  #if user wants to create a club code that is not in the system yet they are prompted
  #for club type and brand
  if input == "h"
    puts "What type of club are you adding to the database? (Driver, Irons, Wedge, or Putter)"
    type = gets.chomp.upcase
    puts "What brand is the club you are adding?"
    brand = gets.chomp.upcase
    
    
    #this takes the first two letters from the brand and then first letter from club type
    #to be combined into the new club code
    code = brand[0]+brand[1]+type[0]
    
    type_options = {"clubcode" => code, "clubtype" => type, "brand" => brand}
    #clubcode class runs the add method to populate the clubcodes table with a new code
    
    
    object = ClubCode.new(type_options)
    object.add
    
  end
  
  
  #this option is for removing a location.  First a list of each location is presented.
  #user is prompted to enter the ID of the store to delete.
  if input == "r"
    Store.all_as_objects.each do |club|
      puts "Store ID -#{club.id} - Location -#{club.location}"
    end
                    
    puts "Which location would you like to remove?"
    store = gets.chomp.to_i
    
    #the Store class runs the remove_location method
    Store.remove_location(store)
    
  end
  
  #this option allows user to see all current locations, club codes and inventory
  if input == "s"
    
    Store.all_as_objects.each do |club|
      puts "Store ID -#{club.id} - Location -#{club.location}"
    end
    ClubCode.all_as_objects.each do |club|
      puts "Club Code - #{club.clubid}   Club Type -#{club.clubtype}   Brand -#{club.brand}"
    end
    Club.all_as_objects.each do |club|
      puts "Store ID - #{club.storeid}  Club Code -  #{club.clubid}  Quantity - #{club.quantity}  Price - #{club.price}"
    end
                   
  end
  
  
  #this option allows the user to move product from one location to another
  #first lists all stores and current inventory
  if input == "c"
    Store.all_as_objects.each do |club|
      puts "Store ID -#{club.id} - Location -#{club.location}"
    end
    Club.all_as_objects.each do |club|
      puts "Store ID - #{club.storeid}  Club Code -  #{club.clubid}  Quantity - #{club.quantity}  Price - #{club.price}"
    end
        
        #user enters the store the product is currently at, the club code, and the store 
        #they want the product moved to              
    puts "What is the store ID the product is currently located at?"
    old_store = gets.chomp.to_i
    puts "What is the club code you wish to move?"
    cid = gets.chomp.to_s
    puts "What is the store ID you wish to move the product to?"
    new_store = gets.chomp.to_i
   
    #then the Club class runs the change_location method
    Club.change_location(old_store, cid, new_store)
  end
  
    
                
  
  #this option lets the user add inventory.  first a list of stores and club codes is listed
  
  if input == "a"
    Store.all_as_objects.each do |club|
      puts "Store ID -#{club.id} - Location -#{club.location}"
     
    end
                   
    #user prompted for the store ID they are adding inventory to
    "Store ID?"
    sid = gets.chomp.to_i
    ClubCode.all_as_objects.each do |club|
      puts "Club Code - #{club.clubid}  Club Type -#{club.clubtype}   Brand -#{club.brand}"
    end
    #User is prompted for Clubcode, quantity of the item being added and the price of each item
    puts "Club Code?"
    cid = gets.chomp.to_s
    puts "Item quantity to add(as a number)?"
    quantity = gets.chomp.to_i
    puts "price per item?"
    price = gets.chomp.to_f
   
    #clubs class runs the add method
    #Club.add(sid, cid, quantity, price)
    options = {"storeid" => sid, "clubid" => cid, "quantity" => quantity, "price" => price}
    club_object = Club.new(options)
    
    
    club_object.addd
    
    
  end
  
  
  #this optoins allows the user to update the information of a current item in inventory
  #lists the current inventory and then prompts user for the Store and Club ID's of the 
  #product to be updated.
  if input == "u"
    puts "Choose a product record to change:"
      
    Club.all_as_objects.each do |club|
      puts "Store ID - #{club.storeid}  Club Code -  #{club.clubid}  Quantity - #{club.quantity}  Price - #{club.price}"
    end
    puts "Enter Store ID"
    chosen_store = gets.chomp.to_i
    puts "Enter Club ID"
    chosen_club = gets.chomp.to_s
         
    puts "Okay. What is the quantity for this item?"
    new_quantity = gets.chomp.to_i
    puts "Okay. What is the price for this item?"
    new_price = gets.chomp.to_f
    
     #clubs class runs the _change_record method
    Club.change_record(chosen_store, chosen_club, new_quantity, new_price)
     
   end     
  
  
  
   #this option allows the user to choose a store and see only that one store's
   #inventory.  Shows user a list of stores to choose from
  if input == "v"
    Store.all_as_objects.each do |club|
      puts "Store ID -#{club.id} - Location -#{club.location}"
    
      

    end
    puts "Choose a store ID to see its inventory:"
    store = gets.chomp.to_i
    #after getting the store ID, clubs class runs the show_items method
    Club.show_items(store)
    
    #this if statement will make it so that only items with the given store id
    #will be listed.
    Club.all_as_objects.each do |club|
      if club.storeid == store
        puts "Store ID - #{club.storeid}  Club Code -  #{club.clubid}  Quantity - #{club.quantity}  Price - #{club.price}"
      end
    end
       
  end
     
     #this option allows the user to delete inventory from records.  Lists all current inventory.
  if input == "d"
    puts "Choose a product to delete from records:"
    Club.all_as_objects.each do |club|
      puts "Store ID - #{club.storeid}  Club Code -  #{club.clubid}  Quantity - #{club.quantity}  Price - #{club.price}"
    end
     #prompts user for store ID and club ID they wish to delete                 
    puts "Store ID:"
    sid = gets.chomp.to_i
    puts "Club ID:"
    cid = gets.chomp.to_s
    
    Club.delete_record(sid, cid)
    
  end
    
    #the code below allows the user 3 seconds to read the output from the preveious action
    #before prompting the loop choices to be given again.
     $stdout.flush  
    sleep(3)
    puts "What would you like to do? "
    puts "(s)ee all stores listed, club codes and clubs in stock?"
    puts "(a)dd a new product? (u)pdate a product's record?"
    puts "(n)ew location?, (h)ave new club code to add?"
    puts "(v)iew a certain store's inventory? "
    puts "(c)hange a product's location. (d)elete a product's records?"
    puts "(r)emove a location? (q)uit"
    input = gets.chomp

end


  
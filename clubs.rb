require_relative "ClassMethods.rb"
require_relative "InstanceMethods.rb"

class Club

  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :storeid

  attr_accessor :clubid, :price, :quantity
  #(CONNECTION.execute("CREATE TABLE IF NOT EXISTS clubs (storeid INTEGER, clubid VARCHAR(5), price FLOAT, quantity INTEGER); ")

  def initialize(club_options={})
    @storeid = club_options["storeid"]
    @clubid = club_options["clubid"]
    @price = club_options["price"]
    @quantity = club_options["quantity"]
  end
  
  
  #method returns a list of all current inventory
  def self.all_as_objects
    results = Club.all
    
    results_as_objects = []
    
    results.each do |result_hash|
    
      results_as_objects << Club.new(result_hash)
   
    
    end
    
    return results_as_objects
  end


  #method inserts new inventory into the clubs table
  def add_to_database(store, club, quant, pri)
    
    
    CONNECTION.execute("INSERT INTO clubs (storeid, clubid, price, quantity) VALUES (#{store}, '#{club}', #{quant}, #{pri});")
    
    
    
    
    
    ##Code for method .add that I haven't been able to get to work
    # results = Club.add
 #
 #    results_as_objects = []
 #
 #    storeid = CONNECTION.last_insert_row_id
 #
 #    Club.new(storeid, clubid, quantity, price)


  end

  #method updates a current inventory listing with new quantity and price information
  def self.change_record(sid, club, new_quantity, new_price)
    CONNECTION.execute("UPDATE clubs SET quantity = #{new_quantity}, price = #{new_price} WHERE storeid = #{sid} AND clubid = '#{club}';")
 
  

  end


  #method allows user to change the location of inventory
  def self.change_location(old_store, club, new_store)
    CONNECTION.execute("UPDATE clubs SET storeid = #{new_store} WHERE storeid = #{old_store} AND clubid = '#{club}';")
    
  end

  #method allows user to see all of the inventory for a given location
  def self.show_items(store)
    results = Club.find(store)
  
    results_as_objects = []
  
    results.each do |result_hash|
    
      results_as_objects << Club.new(result_hash)
    end
    
    return results_as_objects
  end
  

  
  #method allows user to select an inventory listing to be deleted
  def self.delete_record(store_id, club_id)
    CONNECTION.execute("DELETE FROM clubs WHERE storeid = #{store_id} AND clubid = '#{club_id}';")
 
  end
  


end
require_relative "classmethods.rb"
require_relative "InstanceMethods.rb"

class Store
  
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
    
  attr_reader :id
  attr_accessor :location
  # ("CREATE TABLE IF NOT EXISTS stores (id INTEGER PRIMARY KEY, Location VARCHAR(40)); ")
  
def initialize(store_options={})
    @id = store_options["id"]
    @location = store_options["location"]
  end
  
  #method shows all current stores
  def self.all_as_objects
    results = Store.all
    
    results_as_objects = []
    
    results.each do |result_hash|
      results_as_objects << Store.new(result_hash)
    end
    
    return results_as_objects
    
  end
  
  
  def self.find_as_object(id)
    
    result = Store.find(id).first
    
    Store.new(result)
    
  end

  #method allows for a new location to be added
  def self.new_location(sid)
  results = CONNECTION.execute("INSERT INTO stores (location) VALUES ('#{sid}');")
 
  end
  
  
  #method allows for a location to be removed if it has no inventory associated with it
  def self.remove_location(sid)
    result = CONNECTION.execute("SELECT clubid, quantity, price FROM clubs WHERE StoreID=#{sid};")
    if result == []
      CONNECTION.execute("DELETE FROM stores WHERE id = #{sid};")
    else
      puts "This location cannot be removed until it has no inventory"
    end
  end
  
  ##Code that needs worked on
 # def field_value(name_of_field)
    #result = CONNECTION.execute("SELECT #{name_of_field} FROM golfers WHERE id=#{@id};")
   # result.first[name_of_field]
    #end
end
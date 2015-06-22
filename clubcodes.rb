require_relative "ClassMethods.rb"
require_relative "InstanceMethods.rb"

class ClubCode
  
  
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_reader :clubid, :clubtype
  attr_accessor :brand
  #("CREATE TABLE IF NOT EXISTS clubcodes (ClubID id VARCHAR(5), ClubType VARCHAR(40), Brand VARCHAR(40)); ')
 
  
def initialize(type_options={})
    @clubid = type_options["clubid"]
    @clubtype = type_options["clubtype"]
    @brand = type_options["brand"]
  end
  
  #method shows a list of all club codes entered into the clubcodes table
  def self.all_as_objects
    results = ClubCode.all
    
    results_as_objects = []
    
    results.each do |result_hash|
      results_as_objects << ClubCode.new(result_hash)
    end
      return results_as_objects
  end
  
  #method allows users to generate new club codes if Brand and club type are given.
  def add_to_database(code, clubtype, brand)
     CONNECTION.execute("INSERT INTO clubcodes (clubid, clubtype, brand) VALUES ('#{code}', '#{clubtype}', '#{brand}');")
  end
 



  
  ##Code that needs worked on
 # def field_value(name_of_field)
    #result = CONNECTION.execute("SELECT #{name_of_field} FROM golfers WHERE id=#{@id};')
   # result.first[name_of_field]
    #end
end
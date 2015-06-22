require "active_support"
require "active_support/inflector"


module DatabaseClassMethods
  
  def all
    
    table_name = self.to_s.pluralize
  
    results = CONNECTION.execute("SELECT * from #{table_name};")
    
  end
  
  
  def find(storeid)
    
    table_name = self.to_s.pluralize
    
    CONNECTION.execute("SELECT * FROM #{table_name} WHERE storeid = #{storeid};")
    
  end
  
 
  def add(options)



    column_names = options.keys

    values = options.values

    column_names_for_sql = column_names.join(", ")

    individual_values_for_sql = []

    values.each do |value|
      if value.is_a?(String)
        individual_values_for_sql << "'#{value}'"
      else
        individual_values_for_sql << value
      end
    end

    values_for_sql = individual_values_for_sql.join(", ")

    table_name = self.to_s.pluralize



    results = CONNECTION.execute("INSERT INTO #{table_name} (#{column_names_for_sql}) VALUES (#{values_for_sql});")


    id = CONNECTION.last_insert_row_id
    options["id"] = id

    self.new(options)


  end
  
  
end
  
  
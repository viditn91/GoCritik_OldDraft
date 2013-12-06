class Field < ActiveRecord::Base
  # options is to be stored as hash
  serialize :options
  # including Exceptions module from the initializers
  include Exceptions

  after_create :add_column_to_resources, :reload_schema
  before_destroy :remove_column_from_resources_if_empty
  after_destroy :reload_schema
  # before_update :
  after_update :reload_schema
  

  # def change_column_if_empty
  #   column_name = name.to_s
  #   if is_column_empty?(column_name)`
  #     ActiveRecord::Migration.change_column(Resource, column_name, )
  #     true
  #   else
  #     false
  #   end
  # end 
  
protected

  
  def add_column_to_resources
    ActiveRecord::Migration.add_column(Resource, name, input_type, default: default_value )
  end

  def reload_schema
    # Resource.connection.schema_cache.clear!
    Resource.reset_column_information
  end
  
  def remove_column_from_resources_if_empty
    if is_column_empty?(name)
      ActiveRecord::Migration.remove_column(Resource, name)
    else
      raise ColumnNotEmpty.new("Attempt to Delete a Non-Empty Field, Records depend on this field")
    end
  end

  def is_column_empty?(column_name)
    Resource.all.each do |value|
      return false if value.send(column_name.to_sym).present?
    end
  end
end
class Field < ActiveRecord::Base
  # options is to be stored as hash
  serialize :options
  # including Exceptions module from the initializers
  include Exceptions

  after_create :add_column_to_resources, :reload_schema
  before_destroy :remove_column_from_resources_if_empty
  after_destroy :reload_schema
  before_update :change_column_from_resources
  after_update :reload_schema
  

protected
  
  def add_column_to_resources
    ActiveRecord::Migration.add_column(Resource, name, input_type, default: default_value )
  end

  def remove_column_from_resources_if_empty
    if is_column_empty?(name)
      ActiveRecord::Migration.remove_column(Resource, name)
    else
      raise ColumnNotEmpty.new("Attempt to Delete a Non-Empty Field, Records depend on this field")
    end
  end

  def change_column_from_resources
    hash = self.changes
    name = self.name
    #storing the field name in a variable name, so that one migration does not effect the column name in other,
    # which happens if self.name is used
    if hash.keys.include? 'name'
      name = hash["name"].first
    end
    if hash.keys.include? 'input_type'
      if is_column_empty?(name)
        if hash.keys.include? 'default_value'
          ActiveRecord::Migration.change_column(Resource, name, hash["input_type"].second, default: hash["default_value"].second )
        else
          ActiveRecord::Migration.change_column(Resource, name, hash["input_type"].second)
        end
        if hash.keys.include? 'name'
          ActiveRecord::Migration.rename_column(Resource, hash["name"].first, hash["name"].second)
        end
      else
        raise ColumnNotEmpty.new("Attempt to modify a Data Type of a Non-Empty Column, Records depend on this field") 
      end
    else
      if hash.keys.include? 'default_value'
        ActiveRecord::Migration.change_column_default(Resource, name, hash["default_value"].second)
      end
      if hash.keys.include? 'name'
        ActiveRecord::Migration.rename_column(Resource, hash["name"].first, hash["name"].second)
      end
    end
  end

  def is_column_empty?(column_name)
    Resource.pluck(column_name).each do |value|
      return false if value.present?
    end
  end
  
  def reload_schema
    # Resource.connection.schema_cache.clear!
    Resource.reset_column_information
  end
  
end
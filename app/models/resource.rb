class Resource < ActiveRecord::Base

  validate :validates_presence
  validate :validates_uniqueness
  
  private
  
  def validates_presence
    Field.where(required: true).pluck(:name, :display_name).each do |attr, attr_name|
      errors.add attr_name, 'cannot be empty' if self.send(attr).empty?
    end 
  end 

  def validates_uniqueness
    Field.where(unique: true).pluck(:name, :display_name).each do |attr, attr_name|
      errors.add attr_name, 'should be unique, its already in use' if !is_value_unique?(attr)
    end
  end

  def is_value_unique?(attr)
    Resource.pluck(attr).each do |value|
      return false if value == self.send(attr)
    end
  end

end
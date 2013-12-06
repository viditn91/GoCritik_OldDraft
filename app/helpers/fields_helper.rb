module FieldsHelper
  
  def make_hash_readable(options_hash)
    str = ''
    options_hash.each do |hash| 
      str += "Option: #{hash[:text]}, Value: #{hash[:value]} \n"
    end
    str
  end

end

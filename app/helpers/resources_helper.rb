module ResourcesHelper
  
  def options_array_from_hash(options_hash)
    options_array = []
    options_hash.each do |hash|
      options_array << hash.values
    end
    options_array
  end

end

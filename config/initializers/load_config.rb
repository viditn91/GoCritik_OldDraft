
APP_CONFIG = HashWithIndifferentAccess.new(YAML.load_file(File.expand_path('../../config.yml', __FILE__)))
ResourceName = APP_CONFIG[:resource][:name]
InputTypeArray = ['string', 'text', 'integer', 'float', 'decimal', 'datetime', 'timestamp', 
      'time', 'date', 'binary', 'boolean']
FieldTypeArray = [['Text Field','text_field'], ['Text Area', 'text_area'], ['Select Box', 'select'], ['Radio Buttons', 'radio_button_tag']]
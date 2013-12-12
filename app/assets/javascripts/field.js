var ready;

ready = function() {
  // code to append options fields if selectbox/redio buttons are selected
  $(document).on('change','#field_field_type',function() {
    var scope = $(this);
    scope.closest('.form').find('#options_container').html('');
    if(scope.find('option:selected').text() == 'Select Box' || scope.find('option:selected').text() == 'Radio Buttons') {
      add_options(scope);
    }
  });
  // code to append options if the add more options button is clicked
  $(document).on('click','.link_to_add_option', function() {
    var scope = $(this);
    add_options(scope);
  });
  // code to remove options if the remove button is clicked
  $(document).on('click','.link_to_remove_option', function() {
    $(this).closest('div').remove();
  });
};
// function to append option fields
add_options = function(scope) {
  var $options_container = scope.closest('.form').find('#options_container');
  $options_container.find('.link_to_add_option').remove();
  var appended_elements_string = '<div><input name="field[options][][text]" type="text" />'
   + '<input name="field[options][][value]" type="text" />' 
   + '<a class="link_to_remove_option">[-] Remove</a></div>'
   + '<a class="link_to_add_option">[+] Add Another Option</a>';
  $options_container.append(appended_elements_string);
}
// uploading script for the first time
$(document).ready(ready);
// uplaoding script on every page reload
$(document).on('page:load', ready);
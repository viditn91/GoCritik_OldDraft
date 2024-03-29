var ready;

ready = function() {
  // code to append options fields if selectbox/redio buttons are selected
  $('input.form_submit_button').hide();
  $(document).on('change','#_field__field_type',function() {
    var scope = $(this);
    scope.closest('.field_form').find('.options_container').html('');
    if(scope.find('option:selected').text() == 'Select Box' || scope.find('option:selected').text() == 'Radio Buttons') {
      add_options_to_field_type(scope);
    }
  });
  // code to append options if the add more options button is clicked
  $(document).on('click','.link_to_add_options', function() {
    var scope = $(this);
    add_options_to_field_type(scope);
  });
  // code to append options if the add more options button is clicked
  $(document).on('click','.link_to_remove_options', function() {
    $(this).closest('div').remove();
  });
  // code to change the text of the add field button once its clicked
  $(document).on('click', '.form_add_field_button', function() {
    $(this).val('Add Another Field');
    $(this).closest('form').find('input.form_submit_button').show();
  });
  // code to change the text of the add field button once remove is clicked
  $(document).on('click', '.field_form_remove_button', function() {
    scope = $('.form_for_adding_fields');
    if(!scope.find('#fields').textContent) {
      scope.find('.form_add_field_button').val('Add a Field');
      scope.find('input.form_submit_button').hide();
    }
  });
};
// function to append option fields
add_options_to_field_type = function(scope) {
  var $options_container = scope.closest('.field_form').find('.options_container');
  $options_container.find('.link_to_add_options').remove();
  var appended_elements_string = '<div><input name="[field][][options][][text]" type="text" />'
   + '<input name="[field][][options][][value]" type="text" />' 
   + '<a class="link_to_remove_options">[-] Remove</a></div>'
   + '<a class="link_to_add_options">[+] Add Another Option</a>';
  $options_container.append(appended_elements_string);
}
// uploading script for the first time
$(document).ready(ready);
// uplaoding script on every page reload
$(document).on('page:load', ready);
var ready;

ready = function() {
  // code to append options fields if selectbox/redio buttons are selected
  $(document).on('change','#_field__field_type',function() {
    var scope = $(this);
    scope.closest('.field_form').find('.options_container').remove();
    if(scope.find('option:selected').text() == 'Select Box' || scope.find('option:selected').text() == 'Radio Buttons') {
      add_options_to_field_type(scope);
    }
  });
  // code to append options if the add more options button is clicked
  $(document).on('click','.link_to_add_options', function() {
    var scope = $(this);
    scope.text('[x] Remove');
    scope.removeClass('link_to_add_options').addClass('link_to_remove_options');
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
  if(!$options_container.length) {
    scope.closest('.field_form').append('<div class=options_container></div>');
    $options_container = scope.closest('.field_form').find('.options_container');
  }
  var appended_elements_string = '<div><input id=_field__field_type_options type=text name=[field][][options][][text]>'
    + '<input id=_field__field_type_options type=text name=[field][][options][][value]>'
    + '<a class=link_to_add_options>[+] Add more Options</a></div>';
  $options_container.append(appended_elements_string);
}
// uploading script for the first time
$(document).ready(ready);
// uplaoding script on every page reload
$(document).on('page:load', ready);
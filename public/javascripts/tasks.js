document.observe('dom:loaded', function (event) {
//  // Find the button that we want to disable
var task_button = $('task_submit');
//  // Disable it!
  task_button.disabled = true;
// Find the field that is required:
  var required_field_1 = $('task_description');
  // Set up an observer to monitor this field
  new Field.Observer(required_field_1, 0.3, function() {
    //If field == '' then task_button disabled = true
    task_button.disabled = ($F(required_field_1) === '');
    });
});
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function clearText(thefield){
 if (thefield.defaultValue== ' search')
 thefield.value = ""
 thefield.style.color = "#333";

 if (thefield.defaultValue != ' search')
 thefield.style.color = "#333";
}

document.observe('dom:loaded', function (event) {
//  // Find the button that we want to disable
//  //var comment_button = $('comment_submit');
var user_notify_on = $('user_notify_on');

var user_task_notify_false = $('user_task_notify_false')

if (user_task_notify_false.checked == true)
user_notify_on.disabled = true;

new Field.Observer(user_task_notify_false, 0.3, function() {
	user_notify_on.disabled = (user_task_notify_false.checked == true);
});

var task_button = $('task_submit');
//  // Disable it!
//  //comment_button.disabled = true;
  task_button.disabled = true;
//  // Find the field that is required:
//  //var required_field = $('comment_body');
  var required_field_1 = $('task_description');
  
  // Set up an observer to monitor this field
  //new Field.Observer(required_field, 0.3, function() {
    // If field == '' then button disabled = true
    //comment_button.disabled = ($F(required_field) === '');
    //});
  new Field.Observer(required_field_1, 0.3, function() {
    // If field == '' then button disabled = true
    task_button.disabled = ($F(required_field_1) === '');
    });
});
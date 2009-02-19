document.observe('dom:loaded', function (event) {
//  // Find the button that we want to disable
var comment_button = $('comment_submit');
//  // Disable it!
comment_button.disabled = true;
//  // Find the field that is required:
var required_field = $('comment_body');
// Set up an observer to monitor this field
new Field.Observer(required_field, 0.3, function() {
    //If field == '' then comment_button disabled = true
comment_button.disabled = ($F(required_field) === '');
    });
});
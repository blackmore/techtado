document.observe('dom:loaded', function (event) {
	// Check to see if a user is logged in
	if ($('task_description')) {
	  // Find the button that we want to disable
	  var button_array = [$('task_send_email'), $('task_urgent'), $('task_submit')]
	  disable_elements(button_array, $('task_description'))
	  // Disable it!
	};
	if ($('comment_body')) {
	  // Find the button that we want to disable
	  var button_array = [$('freeze'), $('comment_submit')]
	  disable_elements(button_array, $('comment_body'))
	  // Disable it!
	};
	
});

function disable_elements(button_array, trigger){
  button_array.each(function(s){s.disabled = true});

  // Set up an observer to monitor this field
  new Field.Observer(trigger, 0.3, function() {
	button_array.each(function(s){
	  s.disabled = $F(trigger) === ''}
	);
  });
};
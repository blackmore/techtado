
var task_notify_elements_to_disable;
var video_notify_elements_to_disable;


document.observe('dom:loaded', function (event) {
	task_notify_elements_to_disable = [$('user_notify_on_create'), $('user_notify_on_urgent')];
	video_notify_elements_to_disable = [$('user_new_video_notify_all'), $('user_new_video_notify_custom'), $('video_customer_name')];
	
	var task_notify = $('user_task_notify').checked;
	var video_notify = $('user_video_archive_notify').checked
	task_notify_elements_to_disable.each(function(s){s.disabled = !task_notify });
	video_notify_elements_to_disable.each(function(s){s.disabled = !video_notify});
	my_customers();
	if (task_notify) {
		$('notify_techtado').addClassName('tog_on');
	};
	
	if (video_notify) {
		$('notify_video_archive').addClassName('tog_on');
	};
	new Field.Observer($('user_new_video_notify_custom'), 0.3, function() {	my_customers ()});
	
	
});

function my_customers () {
	var my_customer_div = $('my_customers');
	if (($('user_video_archive_notify').checked) && ($('user_new_video_notify_custom').checked)) {
		my_customer_div.removeClassName('gray');
		show_my_customer_links(true);
	}else{
		my_customer_div.addClassName('gray');
		show_my_customer_links(false);	
	};
}

function show_my_customer_links(argument) {
		[$('customers'), $('add_customer')].each(function(s) {
			if (argument) {
				s.removeClassName('hide');
			}else{
				s.addClassName('hide');
			};
		});
};

	

function notify(block){	
	if (block == 'notify_techtado') {
		var task_notify = $('notify_techtado').hasClassName('tog_on');
		task_notify_elements_to_disable.each(function(s){s.disabled = !task_notify });
		$('user_task_notify').checked = task_notify;
		my_customers();
	}else{
		var video_notify = $('notify_video_archive').hasClassName('tog_on');
		video_notify_elements_to_disable.each(function(s){s.disabled = !video_notify});
		$('user_video_archive_notify').checked = video_notify;
		my_customers();
	};
};

function displaymessage() {
	if ($F('video_customer_name') != "") {
		$('customers').insert( { bottom : "<p class='filtered_customer'>" + $F('video_customer_name') + "<a href='#' onclick=\"$(this).up('.filtered_customer').remove(); filter_names(); return false;\">remove</a></p>"});
		$('video_customer_name').clear();
		$('video_customer_name').focus();
		filter_names();
	}else{
		$('video_customer_name').focus();
	};
};

function filter_names() {
	var customer_array;
	var complete_string = "";
	customer_array = $('customers').childElements();
	customer_array.each(function(s) {
	
	var string = s.innerHTML.sub(/<.+/, '');
		if (complete_string == "") {
			complete_string =  string;
		}else{
			complete_string =  complete_string + ", " + string;	
		};
	});
	$('user_new_video_notify_filter').value = complete_string;
};
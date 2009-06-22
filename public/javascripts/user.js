
document.observe('dom:loaded', function (event) {
	if ($('user_task_notify').checked == true){
		$('notify_techtado').addClassName('tog_on')
	}else{
		$('user_notify_on_create').disabled = true;
		$('user_notify_on_urgent').disabled = true;
		$('notify_techtado_content').addClassName('disabled');
	};
	
	if ($('user_video_archive_notify').checked == true){
		$('notify_video_archive').addClassName('tog_on');
		do_something();
	}else{
		$('user_new_video_notify_all').disabled = true;
		$('user_new_video_notify_custom').disabled = true;
		$('customers').addClassName('remove');
		$('add_customer').addClassName('remove');
		$('notify_video_archive_content').addClassName('disabled');
		$('video_customer_name').addClassName('disabled');
	};
});

function notify_task() {
	if ($('notify_techtado').hasClassName('tog_on')) {
		$('user_task_notify').checked=true;
		$('user_notify_on_create').disabled = false;
		$('user_notify_on_urgent').disabled = false;
		$('notify_techtado_content').removeClassName('disabled');
	}else{
		$('user_notify_on_create').disabled = true;
		$('user_notify_on_urgent').disabled = true;
		$('notify_techtado_content').addClassName('disabled');
		$('user_task_notify').checked=false;
	};
};

function notify_video_archive() {
	do_something();
	if ($('notify_video_archive').hasClassName('tog_on')) {
		$('user_video_archive_notify').checked = true;
		$('user_new_video_notify_all').disabled = false;
		$('user_new_video_notify_custom').disabled = false;
		$('video_customer_name').disabled = false;
		$('notify_video_archive_content').removeClassName('disabled');
		do_something();
	}else{
		$('customers').addClassName('remove');
		$('add_customer').addClassName('remove');
		$('user_video_archive_notify').checked = false;
		$('user_new_video_notify_all').disabled = true;
		$('user_new_video_notify_custom').disabled = true;
		$('video_customer_name').addClassName('disabled');
		$('notify_video_archive_content').addClassName('disabled');

	};
};

function do_something(){
	if ($('user_new_video_notify_custom').checked) {
		$('video_customer_name').disabled = false;
		$('video_customer_name').removeClassName('disabled');
		$('customers').removeClassName('remove');
		$('add_customer').removeClassName('remove');
		$('notify_video_archive_content').removeClassName('disabled');
	}else{
		$('customers').addClassName('remove');
		$('add_customer').addClassName('remove');
		$('video_customer_name').addClassName('disabled');
		$('notify_video_archive_content').addClassName('disabled');
		$('video_customer_name').disabled = true;
	};
};
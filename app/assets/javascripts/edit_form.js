$(document).ready(function() {
	// configure date picker for rails
	$("#date_field").datepicker({
		dateFormat: 'yy-mm-dd'
	});
	// make sure correct event times are displayed and not the clockpicker defaults
	$("#edit_form_clockpicker").clockpicker({
		donetext: 'Done',
		placement: 'top',
    	align: 'left'
	});

});
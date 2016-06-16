$(document).ready(function() {

	$('.clockpicker').clockpicker({
		donetext: 'Done',
		placement: 'top',
    	align: 'left'
	});

	$.each($(".event_filler"), function() {
		var id = $(this).data("id");
		// set height
		$("#" + id).css("height", function() {
			return $(this).data("duration");
		});
		// set position
		$("#" + id).css("top", function() {
			var x = $(this).data("startpos");
			return x
		});
		// set colour
		$("#" + id).addClass($(this).data("colour"));
	});
});
$(document).ready(function() {

	$('.clockpicker').clockpicker({
		donetext: 'Done',
		placement: 'top',
    	align: 'left'
	});

	$.each($(".event_filler"), function() {
		var id = $(this).data("id");
		var duration = $(this).data("duration");
		var colour = $(this).data("colour");
		// set height
		if (duration <= 36) {
			$("#" + id).addClass("small_" + colour);
			$("#" + id).css("height", function() {
				return $(this).data("duration");
			});
		} else {
			$("#" + id).css("height", function() {
				return $(this).data("duration");	
			});
			// set colour
			$("#" + id).addClass($(this).data("colour"));
		}
		// set position
		$("#" + id).css("top", function() {
			var x = $(this).data("startpos");
			return x
		});
		
	});
});
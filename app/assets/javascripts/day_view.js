$(document).ready(function() {

	$('.clockpicker').clockpicker({
		donetext: 'Done'
	});

	var width = $(".my_day, td").width();

	

	$.each($(".event_filler"), function() {
		var x = $(this).data("id");
		$("#" + x).css("height", function() {
			return $(this).data("duration");
		});
		$("#" + x).css("top", function() {
			var x = $(this).data("startpos");
			return x
		});
	});
});
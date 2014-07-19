
$(document).ready(function() {
	var f = function (e) {
	    e.preventDefault()
	    $(this).tab('show')
	};
	$('a[href="#build-linux"]').hover(f);
	$('a[href="#build-windows"]').hover(f);
	$('a[href="#build-mac"]').hover(f);

	$("#get-sources").height($("#get-packages").height());
	$("#get-packages").height($("#get-packages").height());
    });

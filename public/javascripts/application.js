// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// get image's offset
//$$('.screenshot-zoom img')[0].positionedOffset();
// get image's width
//$$('.screenshot-zoom img')[0].getWidth()



window.onload = function(){
	
	// show the lightbox
	Event.observe($$('.screenshot a')[0], 'click', function(event) {
		$$('.screenshot-zoom')[0].style.display = "block";
		Event.stop(event);
	});

	// hide the lightbox
	Event.observe($$('.screenshot-zoom, .screenshot-zoom a')[0], 'click', function(event) {
		var element = Event.element(event);
		if ('DIV' == element.tagName || 'A' == element.tagName)
		$$('.screenshot-zoom')[0].hide();
		Event.stop(event);
	});

}
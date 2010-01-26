// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// get image's offset
//$$('.screenshot-zoom img')[0].positionedOffset();
// get image's width
//$$('.screenshot-zoom img')[0].getWidth()



window.onload = function(){
	
	// show the lightbox
	Event.observe($$('.screenshot a')[0], 'click', function(event) {
		
		// calculate the margin of the image to center it accurately
		img = $$('.screenshot-zoom img')[0];
		w = img.width;
		img.style.marginLeft = "-"+w/2+"px";

		// calculate the offset of the close button to position over top right of image
		corner_close = $$('.screenshot-zoom > a')[0];
		corner_close.style.marginLeft = w/2+"px";
		
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
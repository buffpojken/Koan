$(document).ready(function(){
	var koan_btn = $("<div>").attr('id', 'koan-btn');	
	$("body").append(koan_btn);
	koan_btn.mouseover(function(){
		$(this).animate({'left':'0px'});
	});
	koan_btn.mouseout(function(){
		$(this).animate({'left':'-20px'});
	});
	koan_btn.click(function(){
		$.ajaxPopin('/koan/issues/new', {
			loader:true,
			loading_message: ''
		});
	});
});
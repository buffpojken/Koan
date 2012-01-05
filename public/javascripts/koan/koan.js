$(document).ready(function(){
	var koan_btn = $("<div>").attr('id', 'koan-btn');	
	$("body").append(koan_btn);
	koan_btn.mouseover(function(){
		$(this).animate({'left':'0px'}, 200);
	});
	koan_btn.mouseout(function(){
		$(this).animate({'left':'-20px'}, 200);
	});
	koan_btn.click(function(){
		$.ajaxPopin('/koan/issues/new', {
			loader:true,
			loading_message: '',
			post_switch_callback: function(){
				// This should really not be dependent on external methods .daniel
				_setup_input();
			}
		});
	});
	window.post_koan = function(){
		var data = {authenticity_token:_m(), feedback: {description: $("#koan-description-field").val(), 'requester-email': $("#koan-requester-email").val()}};
		var _cnt = $(".popin-header").add('#koan-popin-body').detach();
		$("#ajax-popin").addClass('loading');
		$.ajax({
			url:'/koan/issues', 
			data: data, 
			type:'POST', 
			dataType:'json', 
			success: function(data){
				$("#ajax-popin").removeClass('loading').find('.popin-content').append(_cnt).find('#koan-popin-body').empty();
				var _notice = $("<p>").html(data.message);
				$("#ajax-popin").find('h1').html('Thanks!');
				$("#koan-popin-body").append(_notice);
				setTimeout(function(){
					$.closePopin();
				}, 3000);
			}, 
			error: function(){
				$("#ajax-popin").removeClass('loading').find('.popin-content').append(_cnt);
			}
		})
	}
});
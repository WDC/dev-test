// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function (event) {
  $(document).trigger('page:load');
$('.complete').click(function (event){
	var id = $(this).data('id');
	if($(this).attr('checked')){
		var task = "f";
	}
	else {
		var task = "t";
	}
	$.ajax({
		url: '/tasks/'+ id +'/marker.json',
		type: "POST",
		data: {
			complete: task
		},
		dataType: 'json'
	});
});

$('.archive').click(function(event){
	var id = $(this).data('id');
	$.ajax({
		url: '/tasks/'+ id +'/archiver.json',
		type: "POST"
	});
});
});

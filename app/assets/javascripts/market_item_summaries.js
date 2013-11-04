//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//Jquery function to call marketsummaries#filter when a select's value is changed.
$(document).ready(function(){
	//On change, trigger this function
	$("#station_select, #listing_character, #owner, #type").change(function(){
		//Load all select's values into variables
		var ss = $("#station_select").val();
		var ls = $("#listing_character").val();
		var ow = $("#owner").val();
		var ty = $("#type").val();
		//Fire an AJAX call to marketsummaries/filter
	    $.ajax({
	    	url: "marketsummaries/filter", type: "GET",
	    	//Pass in each variable as a parameter.
	    	data: { station_id: ss, 
	    		listing_character_id: ls, 
	    		owner_id: ow, 
	    		type: ty }
	    });
	});
});




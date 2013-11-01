//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

function dropdownCheck()
{
	//var ss = document.getElementById("station_select").selectedIndex;
	//var ss = document.getElementById("station_select").value;
	//var ls = document.getElementById("listing_character").value;
	//var ow = document.getElementById("owner").value;
	//var ty = document.getElementById("type").value;
	//alert(ss + " " + ls + " " + ow + " " + ty);
	//$("#filter").click(function(){
    //    $.ajax({
    //    	url: "marketsummaries/filter", type: "GET"
    //    	data: {station_select : ss, listing_character : ls, owner : ow, type : ty}
    //    });
    //});
}

$(document).ready(function(){
	$("#station_select").change(function(){
		var ss = $("#station_select").val();
		var ls = $("#listing_character").val();
		var ow = $("#owner").val();
		var ty = $("#type").val();
	    $.ajax({
	    	url: "marketsummaries/filter", type: "GET",
	    	data: { station_id: ss, 
	    		listing_character_id: ls, 
	    		owner_id: ow, 
	    		type: ty }
	    });
	    alert("Unobtrusive!" + ss + ls + ow + ty);
	});

	$("#listing_character").change(function(){
		var ss = $("#station_select").val();
		var ls = $("#listing_character").val();
		var ow = $("#owner").val();
		var ty = $("#type").val();
	    $.ajax({
	    	url: "marketsummaries/filter", type: "GET",
	    	data: { station_id: ss, 
	    		listing_character_id: ls, 
	    		owner_id: ow, 
	    		type: ty }
	    });
	    alert("Unobtrusive!" + ss + ls + ow + ty);
	});

	$("#owner").change(function(){
		var ss = $("#station_select").val();
		var ls = $("#listing_character").val();
		var ow = $("#owner").val();
		var ty = $("#type").val();
	    $.ajax({
	    	url: "marketsummaries/filter", type: "GET",
	    	data: { station_id: ss, 
	    		listing_character_id: ls, 
	    		owner_id: ow, 
	    		type: ty }
	    });
	    alert("Unobtrusive!" + ss + ls + ow + ty);
	});

	$("#type").change(function(){
		var ss = $("#station_select").val();
		var ls = $("#listing_character").val();
		var ow = $("#owner").val();
		var ty = $("#type").val();
	    $.ajax({
	    	url: "marketsummaries/filter", type: "GET",
	    	data: { station_id: ss, 
	    		listing_character_id: ls, 
	    		owner_id: ow, 
	    		type: ty }
	    });
	    alert("Unobtrusive!" + ss + ls + ow + ty);
	});
});

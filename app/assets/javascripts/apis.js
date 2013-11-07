//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){
	//When an API row is clicked
	$("tr[id^='api']").click(function(){
		//The above line uses jQuery's attributeStartsWith selector to find all <tr> tags with ids starting with 'api'.

		//Extract the value attribute from the clicked on api.
		var apiid = $("#" + this.id).attr( 'value' );
		//Extract the array index from the clicked on api.
		var arrayid = this.id.slice(this.id.length -1, this.id.length)
		//Check for empty #wsets<x>
		if ($.trim($("#wsets" + arrayid).html())=='')  {
			//Fire an AJAX call to apis#wallet_settings
		    $.ajax({
		    	url: "apis/wallet_settings", type: "GET",
		    	//Pass the apiid to the controller as well as the clicked on index.
		    	data: { api_id: apiid, array_index: arrayid}
		    });
		}
		//Check for non-empty #wsets<x>
		if ($.trim($("#wsets" + arrayid).html())!='') {
			//remove all content from #wsets<x>
			$("#wsets" + arrayid).empty()
		}

		//This could be improved with a hide() and show() pair, but I was unable to fix the logic loop.
	});
});
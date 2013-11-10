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

	$("tr[id^='wsets']").on('change', "input[id^='wallet_']", function(){
		arrayid = this.id.slice(this.id.length -1, this.id.length)
		if($("input[id^='wallet_']").is(':checked')) {
			//alert(this.id);
		} //else if ($("input[id^='wallet_']").is(':unchecked')) {
		//	alert(this.id);
		//}
		var value0 = $("#wallet_0" + arrayid).prop( 'checked' );
		var value1 = $("#wallet_1" + arrayid).prop( 'checked' );
		var value2 = $("#wallet_2" + arrayid).prop( 'checked' );
		var value3 = $("#wallet_3" + arrayid).prop( 'checked' );
		var value4 = $("#wallet_4" + arrayid).prop( 'checked' );
		var value5 = $("#wallet_5" + arrayid).prop( 'checked' );
		var value6 = $("#wallet_6" + arrayid).prop( 'checked' );
		var apiID = $("#api").attr('value');
		var corp = $("#corp").attr('value');
		//alert(corp + " " + apiID + " " + value0 + " " + value1 + " " + value2 + " " + value3 + " " + value4 + " " + value5 + " " + value6);
		$.ajax({
			url: "apis/set_wallet", type: "POST",
			data: {wallet_0: value0, wallet_1: value1, wallet_2: value2, wallet_3: value3, wallet_4: value4, wallet_5: value5, wallet_6: value6, api_id: apiID, corp_id: corp, array_index: arrayid}
		})
	});
});
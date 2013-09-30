//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


var count = 0;
function countChar()
{
	count = document.getElementById("api_v_code").value.length;
	document.getElementById("counter").innerHTML=count + '/64';
	document.getElementById("counter").style.color='White';
	if (count >= 65)
	{
		document.getElementById("counter").innerHTML="Verification Code Character Limit Exceeded";
		document.getElementById("counter").style.color='Red';
	} else
	{
		document.getElementById("counter").style.color='White';
	}
}
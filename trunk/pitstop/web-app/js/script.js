function hideAndShowElement(element1, element2) {
	if (document.getElementById(element1).style.display == "inherit") { 
		document.getElementById(element1).style.display = "none";
		document.getElementById(element2).style.display = "inherit";
	}
	else {
		document.getElementById(element1).style.display = "inherit";
		document.getElementById(element2).style.display = "none";
	}
}

function hideElement(element) {
	document.getElementById(element).style.display = "none";
}

function showElement(element) {
	document.getElementById(element).style.display = "inherit";	
}

function stopRedirectAction(evt){
	evt.preventDefault();
}

window.onload=showElement('onlyActiveTireHotelOccurrences');
window.onload=hideElement('allTireHotelOccurrences');
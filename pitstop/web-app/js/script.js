function hideAndShowElement(element1, element2) {
	if (document.getElementById(element1).style.visibility == "visible") { 
		document.getElementById(element1).style.visibility = "hidden";
		document.getElementById(element2).style.visibility = "visible";
	}
	else {
		document.getElementById(element1).style.visibility = "visible";
		document.getElementById(element2).style.visibility = "hidden";
	}
}

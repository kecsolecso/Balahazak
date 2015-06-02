/**
 * 
 */

function textCheck(element,min,max){
	if(element.value.length < min || element.value.length > max){
		//alert("form field not ok");
		document.getElementById(element.id+"_validate").className = "formFiledProblem";
		return true;
	}else{
		//alert("form field ok");
		document.getElementById(element.id+"_validate").className = "formFieldOK";
		return false;
	}
	
}
function dropDownCheck(element){
	if(element.value == "" || element.value < 0){
		document.getElementById(element.id+"_validate").className = "formFiledProblem";
		return true;
	}
	else{
		document.getElementById(element.id+"_validate").className = "formFiledOK";
		return false;
	}
}
function checkEnter(event,funcToCall){
	var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
	if(keyCode == 13){
		setTimeout(funcToCall,0);
	}
}
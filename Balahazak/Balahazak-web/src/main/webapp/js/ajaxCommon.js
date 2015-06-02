request = null;
var ajaxForms = new Array();
var dtables = new Array();
var synchCall = true;
var queue = new Array();
function sendGetRequest(dataList) {
	//alert("dxfhg");
	request = GetXMLHttpRequest();
	
	//var href = window.location.href;
	//var url = href.substring(0,href.lastIndexOf("IssueTrackerV2/"))+"IssueTrackerV2/communicator.html";
	var data = setAjaxDataWithoutFormInputs(dataList);
	dataList="";
	request.open("POST", ajaxUrl, true);
	request.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF8");
	//request.setRequestHeader("Content-length","65536");
	request.onreadystatechange = ProcessRequest;
	//alert("elküldés előtt: "+data);
	request.send(data);
	//alert("elküldve");
	data = "";
}

function sendGetRequestSincron(dataList) {
	//alert(dataList);
	if (dataList != undefined) {
		//alert("ITT:" + dataList + " : " + synchCall);
		queue[queue.length] = dataList;
	}
	if (synchCall == true && queue.length != 0) {
	//alert("Call! "+synchCall+" "+queue.length)
		//alert("ITT2:" + queue[0]);
		sendGetRequest(queue[0]);
		synchCall = false;
	}
	
	return true;
}

function GetXMLHttpRequest(){
    var object = null;
    
    if (window.XMLHttpRequest){
    	//alert("firefox");
    	object = new XMLHttpRequest();
    	
    } 
    else if (window.ActiveXObject){
    //alert("ie");
    	try{
            object = new ActiveXObject("Msxml2.XMLHTTP");
        }catch(e){
        }
        if (object == null){
        	try{
                object = new ActiveXObject("Microsoft.XMLHTTP");
            }catch(e){
            }
        }
    }
    if (object == null){
        alert("Your browser does not support AJAX");
    }
    return object;
}

function ProcessRequest(){
	if (request.readyState == 4){
        if (request.status == 200 || request.status == 304){        	
            parseMessage();            
        }else{
        	alert("Hiba történt a feldolgozás során!");
        }
        //alert(queue);
        //alert("status: "+request.status+" state: "+request.readyState);	
    }
}

function parseMessage(req) {
	try{
	
		xmlDocument = req.responseXML;
		}
		catch(ex) {
			xmlDocument = request.responseXML;
		}
	if(xmlDocument.getElementsByTagName("redirect").length > 0){
		manageQueue();
		synchCall = true;
		document.location.href = xmlDocument.getElementsByTagName("redirect")[0].childNodes[0].nodeValue;
	}
	else if(xmlDocument.getElementsByTagName("error").length > 0){
		manageQueue();
		synchCall = true;
		alert("A feldolgozás során a következő hiba következett be: "+xmlDocument.getElementsByTagName("error")[0].childNodes[0].nodeValue);
	}
	else{
		var frames = window.frames;
		for(var j=0; j < frames.length;j++){
			parseDocument(frames[j].document);
		}
		parseDocument(window.document);
	}
}

function parseDocument(document){
	if(document.forms.length==0) return;
	for(var i=0;i<document.forms[0].elements.length;i++){
		try{
			var message = "";
			var elementId = document.forms[0].elements[i].id;
			if((elementId == null) || (elementId == "undefined")){
				var elementName = document.forms[0].elements[i].name;
				message = xmlDocument.getElementsByTagName(elementId);
				for(a=0;a<message.length;a++){
					var sm = message[a].childNodes[0].nodeValue;
					setMessage(sm, elementId,document);
				}
			}
			else if(elementId == "");
			else{
				message = xmlDocument.getElementsByTagName(elementId);
				for(a=0;a<message.length;a++){
					if(document.getElementById(elementId).type != "select-one"){											
						
						if(message[a].childNodes[0] != undefined){
							var sm = message[a].childNodes[0].nodeValue;
							setMessage(sm, elementId,document);
						}
						
					
					}else{
						var sm = "";
						var smi = 0;
						var vmi = false;
						while((sm != null)||(sm!=undefined)){
	       					try{
								sm = message[a].childNodes[smi].childNodes[0].nodeValue+","+message[a].childNodes[smi+1].childNodes[0].nodeValue;
								if(!vmi){
									document.getElementById(elementId).options.length = 1;
									vmi = true;
								}
								setMessage(sm, elementId,document);
								smi=smi+2;
								
							}catch(err){
								try{
									if(smi == 0){
										sm = message[a].childNodes[0].nodeValue
										setMessage(sm, elementId,document);
									}
								}catch(err){}
								sm=null;
	       					}
						}
						vmi = false;
					}
				}
			}
		}catch(err){
			alert("Hiba történt a feldolgozás során!");
			manageQueue();
		}
	}
	for(var i =0; i < document.getElementsByTagName("div").length; i++){
		//try{
		var elementId = document.getElementsByTagName("div")[i].id;
		//alert("elem Id"+elementId);
		message = new Array();
		if(elementId != "") message = xmlDocument.getElementsByTagName(elementId);
		if(message.length > 0){
			if(typeof(window['dtable_exists'])!="undefined") {
				//alert("bele jut");
				for(var c=0;c<this.dtables.length;c++)
					if(dtables[c][0]==elementId) this.dtables[c][1].process(message);
			}
			var sm = "";
			var smi = 0;
			while((sm != null)||(sm!=undefined)){
				try{
					sm = message[0].childNodes[smi].childNodes[0].nodeValue+","+message[0].childNodes[smi+1].childNodes[0].nodeValue;
					if(elementId != "div_tree"){
						setMessage(sm, elementId,document);
					}
					smi=smi+2;
				}catch(err){
					try{
						if(smi == 0){
							sm = message[0].childNodes[0].nodeValue;
							if(elementId != "div_tree"){
							//A firefox ha 4096 (opera 32k) a valasz hossza nem írja ki csak az elso 4 (32) k-t, mert a maradekot a masodik tombbe rakja
								//alert(sm.length+" & " +message[0].childNodes.length);
								if(sm.length ==  4096){
								for(i=1; i<message[0].childNodes.length; i++){
									sm += message[0].childNodes[i].nodeValue;
									}
								}
								setMessage(sm, elementId,document);
							}
						}
					}catch(err){
						//alert("catch2");
						sm=null;
					}
					if(elementId == "div_tree" && message.length > 0){
						d = new dTree('d');
					    eval(sm);
					    document.getElementById(elementId).innerHTML = d;
					    var openTo = xmlDocument.getElementsByTagName("openTo");
					    if(openTo.length > 0){
					    	//alert("nem null:"+openTo[0].childNodes[0].nodeValue);
					    	d.openTo(openTo[0].childNodes[0].nodeValue,true);
					    }
					}
					sm=null;
				}
			}
		}
	}
	//alert("q: " + queue.length);
	manageQueue();
}

function manageQueue() {
	if(queue.length > 1){
			for (var i = 0; i < queue.length; i++) {
				queue[i] = queue[i + 1];
			}
			queue.length = queue.length -1;
		//}catch(err){alert("errrrrrrrrr"+err);}
		} else if (queue.length == 1) {
			queue.length = 0;
		}
		
		synchCall = true;
		
		if (queue != undefined &&  queue.length != 0) {
        	sendGetRequestSincron();
        }
}

function setMessage(message, elementId,document) {
	//alert(message);
	if(document.getElementById(elementId).type == "text" || 
	   document.getElementById(elementId).type == "password" || 
	   document.getElementById(elementId).type == "textarea" ||
	   document.getElementById(elementId).type == "hidden"){
	    document.getElementById(elementId).value = message;
	}
	if(document.getElementById(elementId).type == "checkbox"){
		for(i=0;i<document.forms[0].elements.length;i++){
			var cbs = window.document.forms[0].elements[i];
			if(cbs.type=="checkbox"){
				if(elementId == cbs.id && cbs.value == message){
					cbs.checked=true;
				}
			}
		}
	}
	if(document.getElementById(elementId).type == "select-one"){
		var sma = message.split(",");
		if(sma.length<2){
			for(var si=0;si<document.getElementById(elementId).options.length;si++){
				if(document.getElementById(elementId).options[si].value == sma[0]){
					document.getElementById(elementId).options[si].selected = true;
				}
			}
		}else{
			if(document.getElementById(elementId).options.length > 1){
				for(var smai=0;smai<sma.length;smai=smai+2){
	    			document.getElementById(elementId).options[(document.getElementById(elementId).options.length)] = new Option(sma[smai+1],sma[smai]);
	    		}
	    	}else{
				for(var smai=0;smai<sma.length;smai=smai+2){
	    			document.getElementById(elementId).options[(document.getElementById(elementId).options.length)] = new Option(sma[smai+1],sma[smai]);
	    		}
	    	}
	    }
	}
	if(document.getElementById(elementId).id.indexOf("div") == 0){//.getElementsByTagName == "td"){
		//alert("vok");
		//alert("message.length ="+message.length);
		document.getElementById(elementId).innerHTML = message;
		if(elementId == "div_selected_users"){
			/*alert(document.getElementById("div_selected_users").innerHTML);
			alert(document.getElementById("div_selected_users").
						getElementsByTagName("table").length);*/
			var rows = document.getElementById("div_selected_users").
						getElementsByTagName("table")[0].
							getElementsByTagName("tbody")[0].
								getElementsByTagName("tr");
	
			for(var i=0;i<rows.length;i++){
				//alert(rowTds[0].innerHTML);
				var rowTds = rows[i].getElementsByTagName("td");
				//alert(rowTds[0].innerHTML);
				selectedUsers[selectedUsers.length] = rowTds[0].innerHTML +","+
													  rowTds[1].innerHTML +","+
													  rowTds[2].innerHTML +","+
													  rowTds[3].innerHTML +",";
			}
		}
	}
	if(document.getElementById(elementId).id.indexOf("td") == 0){
		// TODO
		alert("td");
	}
	if(document.getElementById(elementId).id.indexOf("span") == 0){
		// TODO	
		alert("span");
	}
}
function setAjaxData(dataList){
	var data="";
	var frames = window.frames;
	data += collectData(dataList,document);
    if(dataList.length>0){
    	for(var ii=0;ii<dataList.length;ii++){
    		data += (data.length > 0 ? "&" : "")+ dataList[ii][0]+"="+ dataList[ii][1];
    	}
    }
	return data;
}
function setAjaxDataWithoutFormInputs(dataList){
	//alert("withoutFormInput");
	var data="";
	if(dataList.length>0){
    	for(var i=0;i<dataList.length;i++){
    		data += (data.length > 0 ? "&" : "")+ dataList[i][0]+"="+ dataList[i][1];
    	}
    }
	return data;
}
function collectData(dataList,element){
	var formss = element.forms;
	var data = "";
	if(formss.length > 0){
		for(var i=0;i<element.forms[0].elements.length;i++){
	    	if(element.forms[0].elements[i].type == "checkbox"){
	    		if(element.forms[0].elements[i].checked){
	    			data += (i > 0 ? "&" : "")+ element.forms[0].elements[i].id+"="+ element.forms[0].elements[i].value;
	    		}
	    	}else{
	    		if(element.forms[0].elements[i].value != "" ){
	    			data += (i > 0 ? "&" : "")+ element.forms[0].elements[i].id+"="+ element.forms[0].elements[i].value;
	    		}
	    	}
	    }
    }
    return data;
}
/*
function collectData(dataList,element){
	var formss = element.forms;
	var data = "";
	if(formss.length > 0 && ajaxForms.length > 0){
		for(var f=0;f<ajaxForms.length;f++)
		if(element.forms[ajaxForms[f]])
		for(var i=0;i<element.forms[ajaxForms[f]].elements.length;i++){
	    	if (element.forms[ajaxForms[f]].elements[i].type == "checkbox" ||
		    	element.forms[ajaxForms[f]].elements[i].type == "radio"){
	    		if(element.forms[ajaxForms[f]].elements[i].checked){
	    			data += (i > 0 ? "&" : "")+ escape(element.forms[ajaxForms[f]].elements[i].id)+"="+ escape(element.forms[ajaxForms[f]].elements[i].value);
	    		}
	    	}else{
	    		if (element.forms[ajaxForms[f]].elements[i].value != "undefined" ||
	    			element.forms[ajaxForms[f]].elements[i].value != ""){
	    			data += (i > 0 ? "&" : "")+ escape(element.forms[ajaxForms[f]].elements[i].id)+"="+ escape(element.forms[ajaxForms[f]].elements[i].value);
	    		}
	    	}
	    }
    }
    return data;
}*/
function WriteLayer(ID,parentID,URL) {
	//alert("vmi");
	var frames = window.frames;
	for(var i =0; i < frames.length; i ++){
		//alert("frames");
		framesWriteLayer(frames.document,ID,parentID,URL);
	}
	framesWriteLayer(document,ID,parentID,URL);
}
function framesWriteLayer(doc,ID,parentID,URL){
	if (doc.layers) {
		var oLayer;
		if(parentID){
			oLayer = eval('document.' + parentID + '.document.' + ID + '.document');
		}else{
			oLayer = doc.layers[ID].document;
		}
		oLayer.open();
		oLayer.write(URL);
		oLayer.close();
	} else if (parseInt(navigator.appVersion)>=5&&navigator.appName=="Netscape") {
		doc.getElementById(ID).innerHTML = URL;
	} else if (doc.all) doc.all[ID].innerHTML = URL
}

function AddToLayer(ID,parentID,URL) {
	var frames = window.frames;
	for(var i =0; i < frames.length; i ++){
		//alert("frames");
		framesAddToLayer(frames.document,ID,parentID,URL);
	}
	framesAddToLayer(document,ID,parentID,URL);
}
function framesAddToLayer(doc,ID,parentID,URL){
	if (doc.layers) {
		var oLayer;
		if(parentID){
			oLayer = eval('document.' + parentID + '.document.' + ID + '.document');
		}else{
			oLayer = doc.layers[ID].document;
		}
		oLayer.open();
		oLayer.write(doc.layers[ID].document.all+URL);
		oLayer.close();
	} else if (parseInt(navigator.appVersion)>=5&&navigator.appName=="Netscape") {
		doc.getElementById(ID).innerHTML += URL;
	} else if (doc.all) doc.all[ID].innerHTML += URL
}
function delayUntilResponse(elementId,checkValue,funcToCall){
	if (document.getElementById(elementId) == null || 
			document.getElementById(elementId).value != checkValue)
		setTimeout("delayUntilResponse('"+elementId+"','"+checkValue+"','"+funcToCall+"');",100);
	else {
		setTimeout(funcToCall,0);
	}
	return true;
}
function wait(msecs){
	var start = new Date().getTime();
	var cur = start
	while (cur - start < msecs) {
		cur = new Date().getTime();
	}
}


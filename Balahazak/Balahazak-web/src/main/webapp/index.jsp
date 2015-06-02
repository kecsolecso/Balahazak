<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page pageEncoding="UTF-8"%>
<html>
	<head>
		<title>Balaházak, Balatoni Zoltán közös képviselő, ingatlankezelő, társasházkezelő hivatalos weboldala</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="description" content="Balatoni Zoltán közös képviselő több társasház közös képviseletét látja el, 
			illetve képesített ingatlankezelő. Ingatlan, illetve társasházkezeléssel 
			valamint közös képviselettel kapcsolatban forduljon hozzá bizalommal.">
		<meta name="keywords" content="ingatlankezelés, társasházkezelés, közös képviselet, 
			közös képviselő, Balatoni Zoltán, társasház, ingatlan, közös költség">
		<meta name="title" content="Balaházak">
		<meta name="author" content="Csaba Kecse-Nagy">
		<link rel="stylesheet" type="text/css" href="css/common.css">
		<link rel="shortcut icon" href="img/favicon_2.ico" type="image/x-icon" />
		<script type="text/javascript" src="js/ajaxCommon.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript">
			var contextPath = 
				"<%=request.getRequestURL().toString().contains("localhost")? request.getContextPath():""%>";
    		var ajaxUrl = "";
    		var showPage = "div_introduction";
    		//var docsDir = "";
    		var selected_horisontal_menu = "";
    		var sWindow;
    		$.ajaxSetup({
			    type: "POST",
			    timeout: 10000,
			    contentType: "application/x-www-form-urlencoded; charset=utf-8"        
			}); 
			function changeDivAppearance(page){
				document.getElementById(showPage).style.display = "none";
				showPage = page;
				document.getElementById(showPage).style.display = "block";
			}
			function changeContent(page){
				//alert("vagyok");
				changeDivAppearance(page);
				$.ajax({
					url: contextPath + "/ManageChangableContent",
					type: 'POST',
					async: false,
					datatype: "xml",
					data: {
						action: "getContent",
						page: page
					},
					success: function (xml){
						//alert("ok");
						$("#"+page+"").html($(xml).find(page).text());
					},
					error: function(){
						alert("Hiba az oldalon!1");
					}
				});
				$.ajax({
					url: contextPath + "/ServePHP",
					type: 'POST',
					async: false,
					datatype: "xml",
					data: {
						action: "getDemoURL"
					},
					success: function (xml){
						//alert("ok");
					},
					error: function(){
						alert("Hiba az oldalon!2");
					}
				});
				//alert("vagyok2");
			}
			
			function sendBugReport(){
				//alert("sendProposal");
				if(!validateElement(document.getElementById("div_riportbug"))){
					ajaxUrl = contextPath + "/SendMail";
					document.getElementById("ajaxresponse").value = 0;
					var dataToSend = collectInputElements(document.getElementById("div_riportbug"));
					var data=new Array(
						["action","sendBugReport"],
						["subject","Hibabejelentés"],
						["data",dataToSend]);
					sendGetRequestSincron(data);
					//alert("kérés elküldve");
					delayUntilResponse("ajaxresponse","1","informUserSuccessAction(\"div_riportbug\");");
				}
			}
			function collectInputElements(element){
				var inputs = element.getElementsByTagName("input");
				var textareas = element.getElementsByTagName("textarea");
				var dataToSend = "";
				for(var i=0; i<inputs.length;i++){
					if((inputs[i].type=="radio" && inputs[i].checked) || inputs[i].type=="text")
						dataToSend += inputs[i].name + ": "+inputs[i].value+"#";
				}
				for(var i=0; i<textareas.length;i++){
					dataToSend += textareas[i].name + ": "+textareas[i].value+"#";
				}
				//alert(dataToSend);
				return dataToSend;
			}
			function emptyingInputElements(element){
				//alert("emptiing");
				var inputs = element.getElementsByTagName("input");
				var textareas = element.getElementsByTagName("textarea");
				for(var i=0; i<inputs.length;i++){
					if(inputs[i].type=="text")
						inputs[i].value = "";
				}
				for(var i=0; i<textareas.length;i++){
					textareas[i].value = "";
				}
			}
			function validateElement(element){
				var res = false;
				//alert(element.id);
				var elements = $("#"+element.id+" .required");
				for(var i=0; i<elements.length;i++){
					res = textCheck(elements[i],1,400);
				}
				//alert(res);
				return res;
			}
			function setSelectedHorisontalMenu(id){
				//alert(id);
				if(selected_horisontal_menu != ""){
					//alert("volt már kiválaszott menüpont");
					document.getElementById(selected_horisontal_menu).className = "horisontal deselected";
				}
				selected_horisontal_menu = id;
				document.getElementById(id).className = "horisontal selected";
			}
			var _gaq = _gaq || [];
			  _gaq.push(['_setAccount', 'UA-21770228-1']);
			  _gaq.push(['_trackPageview']);
			
			  (function() {
			    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
			    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
			  })();
		</script>
	</head>
	<body onLoad="changeContent('div_introduction');setSelectedHorisontalMenu('introduction');">
		<form action="#">
			<input type="hidden" id="ajaxresponse" value="0">
			<input type="hidden" id="loggableUser" value="0">
				
			<table class="main_table" >
				<tr>
					<td class="logo"><a class="logo" href="/"></a></td>
					<td class="menu_horisontal" id="menu_horisontal" >
						<ul class="horisontal">
							<li><a class="horisontal" href="/" id="introduction">
								Bemutatkozás
							</a></li>
							<li><!-- href="sendphpdata.jsp"target="_blank" -->
							<a class="horisontal" id="login" href="/kozoskoltseg/tarsashazibelepes.jsp" >
								Bejelentkezés
							</a></li>
							<li><a class="horisontal" href="/tarsashaz/referenciak.jsp" id="references">
								Referenciák
							</a></li>
							<li><a class="horisontal" href="/tarsashaz/ajanlatkeres.jsp" id="askproposal">
								Ajánlatkérés
							</a></li>
							<li><a class="horisontal" href="/kozoskepviselo/kapcsolat.jsp" id="contact">
								Kapcsolat
							</a></li>
							<li><a class="horisontal" href="/tarsashaz/dokumentumok.jsp" id="docs">
								Dokumentumok
							</a></li>
							<li><a class="horisontal" href="/kozoskepviselo/kozoskepviselopartnerek.jsp" id="partners">
								Partnerek
							</a></li>
							<li><a class="horisontal" href="/kozoskoltseg/kozerdeku.jsp" id="common">
								Közérdekű
							</a></li>
						</ul>
					</td>					
				</tr>
			</table>
			<table class="main_table" style="height:100%;">
				<tr style="height:100%;">
					<td class="menu_vertical">
						<ul class="vertical">
							<li><a class="vertical_green_menu" href="/">
								<span class="top">BEMUTATKOZÁS</span>
								<span class="bottom">ISMERJE MEG CÉGÜNKET</span>
							</a></li>
							<li><a class="vertical_light-green_menu" href="/kozoskoltseg/tarsashazibelepes.jsp">
								<span class="top" style="font-style:italic;font-weight:bold">
									*** BEJELENTKEZÉS ***
								</span>
								<span class="bottom" style="font-style:italic;font-weight:bold">
									*** BELSŐ INFORMÁCIÓK, DOKUMENTUMOK ***
								</span>
							</a></li>
							<li><a class="vertical_blue_menu" href="/tarsashaz/referenciak.jsp">
								<span class="top">REFERENCIÁK</span>
								<span class="bottom">EDDIGI EREDMÉNYEINK</span>
							</a></li>
							<li><a class="vertical_light-blue_menu" href="/tarsashaz/ajanlatkeres.jsp">
								<span class="top">AJÁNLATKÉRÉS</span>
								<span class="bottom">KÉRJEN TŐLÜNK AJÁNLATOT</span>
							</a></li>
							<li><a class="vertical_yellow_menu" href="/kozoskepviselo/kapcsolat.jsp">
								<span class="top">KAPCSOLAT</span>
								<span class="bottom">LÉPJEN KAPCSOLATBA VELÜNK</span>
							</a></li>
							<li><a class="vertical_light-yellow_menu" href="/tarsashaz/dokumentumok.jsp">
							<span class="top">DOKUMENTUMOK</span>
								<span class="bottom">HASZNOS DOKUMENTUMOK</span>
							</a></li>
							<li><a class="vertical_purple_menu" href="/kozoskepviselo/kozoskepviselopartnerek.jsp">
								<span class="top">PARTNEREK</span>
								<span class="bottom">KIEMELT PARTNEREINK</span>
							</a></li>
							<li><a class="vertical_light-purple_menu" href="/kozoskoltseg/kozerdeku.jsp">
								<span class="top">KÖZÉRDEKŰ</span>
								<span class="bottom">HASZNOS LINKEK</span>
							</a></li>
						</ul>
						<div id="menu_gradient"></div>
					</td>
					<td class="content">
						<div id="picture_content">Ingatlankezelés, társasházkezelés<br>Közös képviselő</div>
						<div id="div_introduction"></div>
					</td>
				</tr>
			</table>
			<div id="div_footer">
				<div id="footer_separator"></div>
				<div id="div_info">Társasházkezelés, közös képviselet felső fokon több évnyi közös képviselő tapasztalattal! Munkavégzés elsősorban: Kőbánya, Kispest.</div><br>
				<div id="div_email">e-mail: <a href="mailto:kkbalatoni@gmail.com">kkbalatoni@gmail.com</a></div>
				<div id="div_phone">Mobil: 06-20-967-4857</div>
				<div id="div_tel">Telefon: 06-1-262-5519</div>
				<div id="div_address">
					1105 Budapest Mongol utca 4
				</div>
				<div id="div_developer">Fejlesztette: Kecsó (<a href="mailto:cskecsen@gmail.com">cskecsen@gmail.com</a>) 2014</div>
			</div>
		</form>
	</body>
</html>
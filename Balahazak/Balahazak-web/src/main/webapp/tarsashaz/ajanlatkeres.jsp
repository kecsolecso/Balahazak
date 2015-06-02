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
		<link rel="stylesheet" type="text/css" href="../css/common.css">
		<link rel="shortcut icon" href="../img/favicon_2.ico" type="image/x-icon" />
		<script type="text/javascript" src="../js/ajaxCommon.js"></script>
		<script type="text/javascript" src="../js/common.js"></script>
		<script type="text/javascript" src="../js/jquery.js"></script>
		<script type="text/javascript">
			var contextPath = 
				"<%=request.getRequestURL().toString().contains("localhost")? request.getContextPath():""%>";
    		$.ajaxSetup({
			    type: "POST",
			    timeout: 10000,
			    contentType: "application/x-www-form-urlencoded; charset=utf-8"        
			});
    		
			function onLoad(){
				document.getElementById("askproposal").className = "horisontal selected";
			}
			function logout(){
				$.ajax({
					url: contextPath + "/ServePHP",
					type: 'POST',
					async: false,
					datatype: 'xml',
					data: {
						action: "logoutUser"
					},
					success: function (xml){
						document.getElementById("menu_horisontal").style.display = "table";
						document.getElementById("menu_horisontal_inner").style.display = "none";
						setSelectedHorisontalMenu('introduction');
						changeContent('div_introduction');
						/*$(window).tabs("remove",0);
						closeWindow();*/
						alert("Ön sikeresen kilépett!");
					},
					error: function(){
						alert("Hiba az oldalon");
					}
				});
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
			function sendProposal(){
				//alert("sendProposal");
				if(!validateElement(document.getElementById("div_askproposal"))){
					ajaxUrl = contextPath + "/SendMail";
					document.getElementById("ajaxresponse").value = 0;
					var dataToSend = collectInputElements(document.getElementById("div_askproposal"));
					//alert(dataToSend);
					var data=new Array(
						["action","sendProposal"],
						["subject","Ajánlatkérés"],
						["data",dataToSend]);
					sendGetRequestSincron(data);
					//alert("kérés elküldve");
					delayUntilResponse("ajaxresponse","1","informUserSuccessAction(\"div_askproposal\");");
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
			function informUserSuccessAction(id){
				emptyingInputElements(document.getElementById(id));
				alert("Az e-mail elküldése sikeres volt.");
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
			/*function closeWindow() {
				alert('vmi');
				window.opener = self;
				window.open('','_parent','');
				window.close();
				alert('vmi');
			}*/
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
	<body onLoad="onLoad();">
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
					</td>
					<td class="content">
						<div id="picture_content">Ingatlankezelés, társasházkezelés<br>Közös képviselő</div>
						<div id="div_askproposal">
							<fieldset id="askproposal_fileds">
							<legend>Ajánlatkérés</legend>
							<table id="askproposal_table">
								<tr>
									<td>Település:</td>
									<td><input type="text" id="village" name="Település" class="full_width"></td>
								</tr>
								<tr id="zip_validate">
									<td>*Irányítószám:</td>
									<td><input type="text" id="zip" name="Irányítószám" class="required short_text"></td>
								</tr>
								<tr>
									<td id="address_validate">*Utca:</td>
									<td><input type="text" id="address" name="Utca" class="required full_width"></td>
								</tr>
								<tr>
									<td id="doornumber_validate">*Házszám:</td>
									<td><input type="text" id="doornumber" name="Házszám" class="required short_text"></td>
								</tr>
								<tr>
									<td>Építési év:</td>
									<td><input type="text" id="structured_year" name="Építési év" class="short_text"></td>
								</tr>
								<tr>
									<td>Lépcsőházak száma:</td>
									<td><input type="text" id="stairway" name="Lépcsőházak száma" class="short_text"></td>
								</tr>
								<tr>
									<td>Lakás plusz üzletszám:</td>
									<td><input type="text" id="flats_and_stores" name="Lakás plusz üzletszám" class="short_text"></td>
								</tr>
								<tr>
									<td>Park, kert, zöld terület:</td>
									<td>
										<input type=radio value="Van" name="Park, kert, zöld terület">Van
										<input type=radio value="Nincs" name="Park, kert, zöld terület" checked="checked">Nincs
									</td>
								</tr>
								<tr>
									<td>Lift:</td>
									<td>
										<input type=radio value="Van" name="Lift">Van
										<input type=radio value="Nincs" name="Lift" checked="checked">Nincs
									</td>
								</tr>
								<tr>
									<td>Fűtési rendszer:</td>
									<td>
										<input type=radio value="Egyedi" name="Fűtési rendszer">Egyedi
										<input type=radio value="Távhő" name="Fűtési rendszer" checked="checked">Távhő
										<input type=radio value="Tömb" name="Fűtési rendszer">Tömb
									</td>
								</tr>
								<tr>
									<td>Garázs:</td>
									<td>
										<input type=radio value="Van" name="Garázs">Van
										<input type=radio value="Nincs" name="Garázs" checked="checked">Nincs
									</td>
								</tr>
								<tr>
									<td>Felszíni parkoló:</td>
									<td>
										<input type=radio value="Van" name="Felszíni parkoló">Van
										<input type=radio value="Nincs" name="Felszíni parkoló" checked="checked">Nincs
									</td>
								</tr>
								
								<tr>
									<td>Gondnokság:</td>
									<td>
										<input type=radio value="Van" name="Gondnokság">Van
										<input type=radio value="Nincs" name="Gondnokság" checked="checked">Nincs
									</td>
								</tr>
								<tr>
									<td>SZMSZ (Szervezeti és működési szabályzat):</td>
									<td>
										<input type=radio value="Van" name="SZMSZ (Szervezeti és működési szabályzat)">Van
										<input type=radio value="Nincs" name="SZMSZ (Szervezeti és működési szabályzat)">Nincs
										<input type=radio value="Nem Tudom" name="SZMSZ (Szervezeti és működési szabályzat)" checked="checked">Nem tudom
									</td>
								</tr>
								<tr>
									<td>Ajánlatkérő neve:</td>
									<td><input type="text" id="demander_name" name="Ajánlatkérő neve" class="full_width"></td>
								</tr>
								<tr>
									<td id="demander_email_validate">*Ajánlatkérő e-mail címe:</td>
									<td><input type="text" id="demander_email" name="Ajánlatkérő e-mail címe" class="required full_width"></td>
								</tr>
								<tr>
									<td>Ajánlatkérő telefonszáma:</td>
									<td><input type="text" id="demeander_tel" name="Ajánlatkérő telefonszáma" class="full_width"></td>
								</tr>
								<tr>
									<td>Ajánlatkérő státusza:</td>
									<td>
										<input type=radio value="Tulajdonos" name="Ajánlatkérő státusza" checked="checked">Tulajdonos
										<input type=radio value="SZB tag" name="Ajánlatkérő státusza">SZB tag
									</td>
								</tr>
								<tr>
									<td id="send_askproposal" colspan="2">
										<input type="button" value="Küldés" onClick="sendProposal();">
									</td>
								</tr>
							</table>
							</fieldset>
						</div>
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
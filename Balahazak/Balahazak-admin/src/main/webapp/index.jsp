<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="hb.Admin" %>
<jsp:useBean id="admin" scope="session" class="hb.Admin"></jsp:useBean>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Admin menü</title>
		<link rel="stylesheet" type="text/css" href="css/common.css">
		<script type="text/javascript" src="js/ajaxCommon.js"></script>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript">
            <% if (admin.getName() == null) {%>
            	window.location = "<%= request.getContextPath() + "/login.jsp"%>";
            <%}%>
        </script>
        <script type="text/javascript" src="js/tiny_mce/tiny_mce.js"></script>
		<script type="text/javascript">
			tinyMCE.init({
				// General options
				mode : "textareas",
				theme : "advanced",
				plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist,autosave",
		
				// Theme options
				theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
				theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
				theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
				theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
				theme_advanced_toolbar_location : "top",
				theme_advanced_toolbar_align : "left",
				//theme_advanced_statusbar_location : "top",
				theme_advanced_resizing : false,
		
				// Example content CSS (should be your site CSS)
				content_css : "css/content.css",
		
				// Drop lists for link/image/media/template dialogs
				template_external_list_url : "lists/template_list.js",
				external_link_list_url : "lists/link_list.js",
				external_image_list_url : "lists/image_list.js",
				media_external_list_url : "lists/media_list.js",
		
				// Style formats
				style_formats : [
					{title : 'Bold text', inline : 'b'},
					{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
					{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
					{title : 'Example 1', inline : 'span', classes : 'example1'},
					{title : 'Example 2', inline : 'span', classes : 'example2'},
					{title : 'Table styles'},
					{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
				],
		
				// Replace values for the template plugin
				template_replace_values : {
					username : "Some User",
					staffid : "991234"
				},
				entity_encoding : "raw",
				height : "1200px",
				width : "774px"
			});
		</script>
		<!-- /TinyMCE -->
		<script type="text/javascript">
			var contextPath = "<%=request.getContextPath()%>";
	    	var ajaxUrl = contextPath + "/ManageChangableContent";
	    	var contentShow = "introduction";
	    	var showPage = "div_content";
	    	$.ajaxSetup({
			    type: "POST",
			    timeout: 10000,
			    contentType: "application/x-www-form-urlencoded; charset=utf-8"        
			}); 
			function saveContent(){
				$.ajax({
					url: ajaxUrl,
					//type: 'POST',
					async: false,
					//contentType: "application/x-www-form-urlencoded; charset=utf-8",
					datatype: "xml",
					data: {
						action: "saveContent",
						content: tinyMCE.get('content').getContent(),
						pageName: contentShow
					},
					success: function (xml){
						alert("Az adatokat sikeresen elmentettük!");
					},
					error: function(){
						alert("Hiba az oldalon");
					}
				});
			}
			function getContent(page){
				contentShow = page;
				changeDivAppearance("div_content");
				$.ajax({
					url: ajaxUrl,
					type: 'POST',
					async: false,
					datatype: "xml",
					data: {
						action: "getContent",
						page: contentShow
					},
					success: function (xml){
						tinyMCE.get('content').setContent($(xml).find('hidden_content').text());
					},
					error: function(){
						alert("Hiba az oldalon");
					}
				});
			}
			function saveData(){
				changeDivAppearance("div_footer");
				$.ajax({
					url: contextPath+"/Data",
					type: 'POST',
					async: false,
					datatype: "xml",
					data: {
						action: "saveData",
						email: document.getElementById("email").value,
						address: document.getElementById("address").value,
						phone: document.getElementById("phone").value,
						tel: document.getElementById("tel").value
					},
					success: function (xml){
						alert("Az adatokat sikeresen elmentettük!");
					},
					error: function(){
						alert("Hiba az oldalon");
					}
				});
			}
			function getFooter(){
				changeDivAppearance("div_footer");
				$.ajax({
					url: contextPath+"/Data",
					type: 'POST',
					async: false,
					datatype: "xml",
					data: {
						action: "getData"
					},
					success: function (xml){
						document.getElementById("email").value = $(xml).find('email').text();
						document.getElementById("address").value = $(xml).find('address').text();
						document.getElementById("phone").value = $(xml).find('phone').text();
						document.getElementById("tel").value = $(xml).find('tel').text();
					},
					error: function(){
						alert("Hiba az oldalon");
					}
				});
			}
			function changeDivAppearance(page){
				document.getElementById(showPage).style.display = "none";
				showPage = page;
				document.getElementById(showPage).style.display = "inline";
			}
			function getDocuments(){
				changeDivAppearance("div_docs");
			}
		</script>
	</head>
	<body onLoad="getContent('introduction');">
		
			<table id="main_table">
				<tr>
					<td class="admin_menu">
						<div class="admin_menu_div">
							<ul>
								<li><a class="" href="#" onClick="getContent('introduction');">Bemutatkozás</a></li>
								<li><a class="" href="#" onClick="getContent('references');">Referenciák</a></li>
								<li><a class="" href="#" onClick="getContent('contact');">Kapcsolat</a></li>
								<li><a class="" href="#" onClick="getContent('partners');">Partnerek</a></li>
								<li><a class="" href="#" onClick="getContent('common');">Közérdekű</a></li>
								<li><a class="" href="#" onClick="getFooter();">Lábléc adatok</a></li>
							</ul>
						</div>
					</td>
					<td class="admin_content">
						<div id="div_content">
							<form method="post" action="#">
								<input type="hidden" id="ajaxresponse" name="ajaxresponse">
								<input type="hidden" id="hidden_content" name="hidden_content">
								<textarea id="content" name="content"></textarea>
								<input type="button" value="Mentés" onClick="saveContent();">
							</form>
						</div>
						<div id="div_footer">
							<table>
								<tr>
									<td>E-mail cím:</td>
									<td><input type="text" id="email" name="email" size="50"></td>
								</tr>
								<tr>
									<td>Cím:</td>
									<td><input type="text" id="address" name="address" size="50"></td>
								</tr>
								<tr>
									<td>Mobil:</td>
									<td><input type="text" id="phone" name="phone" size="50"></td>
								</tr>
								<tr>
									<td>Tel:</td>
									<td><input type="text" id="tel" name="tel" size="50"></td>
								</tr>
								<tr>
									<td colspan="2">
										<input type="button" value="Mentés" 
											id="save_data" onClick="saveData();">
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Pass data to PHP</title>
		<script type="text/javascript" src="js/ajaxCommon.js"></script>
		<script type="text/javascript">
			function setPHPData(){
				document.forms[0].action = 
					"<%=((session.getAttribute("ktg_URL") == null) ? 
						"/phps/demo":session.getAttribute("ktg_URL"))+"/ktg_index.php" %>";
				document.getElementById("ktg_user").value = 
					"<%=((session.getAttribute("ktg_user") == null) ? 
						"XY":session.getAttribute("ktg_user"))%>";
				document.getElementById("ktg_password").value = 
					"<%=((session.getAttribute("ktg_password") == null) ?
						"10":session.getAttribute("ktg_password"))%>";
				document.forms[0].submit();
			}
		</script>
	</head>
	<body onLoad="setPHPData();">
		<form method="post" action="#">
			<input type="hidden" id="ktg_user" name="ktg_user">
			<input type="hidden" id="ktg_password" name="ktg_password">
		</form>
	</body>
</html>
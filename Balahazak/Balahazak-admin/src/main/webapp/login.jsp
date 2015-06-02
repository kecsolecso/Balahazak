<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="hb.Admin" %>
<jsp:useBean id="admin" scope="session" class="hb.Admin"></jsp:useBean>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/ajaxCommon.js"></script>
        <title>BalaHázak Admin Bejelentkezés</title>
        <style type="text/css">
            body,html{
                width:100%;
            }
            form{
                height:100%;
                width:100%;
            }
            table.outer{
                position:absolute;
                top:0;
                bottom:0;
                left: 0;
                right: 0;
                height:100%;
                width: 100%;
            }
            table.inner{
                width: 280px;
                height:130px;
                margin: 0 auto;
                text-align:center;
            }
            td.field{
                text-align: left;
            }
            .fullwidth{
                width:100%;
            }
            #background{
                position: absolute;
                width: 100%;
                height: 100%;
            }
            div{
            	display: none;
            	margin: 0 auto;
            }
        </style>
        <script type="text/javascript">
        	var contextPath = "<%=request.getContextPath()%>";
        	var ajaxUrl = contextPath + "/Login";
        	<% if (admin.getName() != null) {%>
        		window.location = contextPath+"/";
        	<%}%>
        	function login(){
                var data = new Array(
	                ["action","login"],
	                ["username",document.loginForm.j_username.value],
	                ["password",document.loginForm.j_password.value]
                );
                sendGetRequestSincron(data);
                document.getElementById("ajaxresponse").value = 0;
                document.getElementById("loggable").value = 0;
                delayUntilResponse("ajaxresponse","1","loggingIn();");
        	}
        	function loggingIn(){
        		if(document.getElementById("loggable").value == 0){
        			document.getElementById("hiddenDiv").style.display = "table";
        		}
        		else{
        			document.getElementById("hiddenDiv").style.display = "none";
        			window.location = "<%= request.getContextPath() + "/" %>";
        		}
        	}
        	function checkEnter(event){
        		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
        		if(keyCode == 13){
        			login();
        		}
        	}
        </script>
    </head>
    <body onload="document.loginForm.j_username.focus();">
        <form name="loginForm" action="#" method="post">
        	<input type="hidden" id="ajaxresponse" value="0">
        	<input type="hidden" id="loggable" value="0">
            <table class="outer">
                <tr>
                    <td>
                    	<div id="hiddenDiv">
	                        <span style="color: red;text-align: center;font-weight: bold">
	                            Hibás felhasználónév vagy jelszó!
	                        </span>
                        </div>
                        <table class="inner">
                            
                            <tr>
                                <td class="field"><b>Felhasználónév:</b></td>
                                <td class="field"><input type="text" id="j_username" name="j_username" 
                                	maxlength="64" class="fullwidth box_sizing" onkeypress="checkEnter(event);"/></td>
                            </tr>
                            <tr>
                                <td class="field"><b>Jelszó:</b></td>
                                <td class="field"><input type="password" id="j_password" name="j_password" 
                                	maxlength="64" class="fullwidth box_sizing" onkeypress="checkEnter(event);"/></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="button" class="basic-w115" name="belepes" value="Belépés" onClick="login();"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>

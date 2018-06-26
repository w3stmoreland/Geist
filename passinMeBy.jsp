<!DOCTYPE html>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="mod.Utility.*" %>
<%@ page import="mod.ValueObject.*" %>
<html>
<head>
<script type="text/javascript">

function modificationConfirmation() {
	
	var confirmed = document.getElementById("update").innerHTML ;
	
    if (confirmed != null) {
        document.getElementById("demo").innerHTML = "You have confirmed " + confirmed + "! ";
    }
	
	return;
}


function actualSourceSelection(elem) {
	
    var tTTT = document.getElementById('selectedSourceAcct').value;
	
    document.getElementById("acctAvailable").innerHTML = "<b>Available: <font color=\"white\">$</b>" + splitTextKey(tTTT);   

	document.getElementById("acctSource").innerHTML = splitTextKey(tTTT);

    return;
}


function actualTargetSelection(elem) {
	
    var tTTT = document.getElementById('selectedTargetAcct').value;
	
	document.getElementById("acctTarget").innerHTML = splitTextKey(tTTT);

    return;
}


function splitTextKey(textSet){
    var textListKey = null;

    if(textSet==null) 
    {
        alert("There was no (key) text to split.");
        return ;
    }

    textListKey = textSet.split(",");
    //
	//alert(textListKey[0]);
    //
	return textListKey[0];
}


function splitTextValue(textSet){
    var textListValue = null;
    if(textSet==null) 
    {
        alert("There was no (value) text to split.");
        return ;
    }

    textListValue = textSet.split(",");
    return textListValue[1];
}


function validate_required(field,alerttxt)
{
with (field)
  {
  if (value==null||value=="")
    {
    alert(alerttxt);
    return false;
    }
  else
    {
    return true;
    }
  }
}


function validate_form(thisform)
{
  
  with (thisform)
  {
	  if (validate_required(lucidInput,"You cannot pass without the passcode.")==false)
  	  {
	   lucidInput.focus();
	   return false;
      }
  }
  
}
</script>
<style type="text/css">
<!--
BODY {
background-image: url(assets/images/sea-creatures-giphy.gif);
font-size: 16px;
	font-family: Georgia;
    background-repeat: no-repeat;
    no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;

	background-color: #FFF;
	margin: 0px;
	padding: 0px;
	font-size: 16px;
	font-family: Georgia;
	}
	
	table.sample {
	border-width: 1px;
	border-spacing: 2px;
	border-style: outset;
	border-color: green;
	border-collapse: separate;
	background-color: white;
}
table.sample th {
	border-width: 1px;
	padding: 1px;
	border-style: none;
	border-color: red;
	background-color: rgb(255, 250, 250);
	-moz-border-radius: ;
}
table.sample td {
	border-width: 1px;
	padding: 1px;
	border-style: none;
	border-color: red;
	background-color: rgb(255, 250, 250);
	-moz-border-radius: ;
}

div.rounded-box {
  border:5px solid #FFFFFF;

    position:relative;
    width: 19em;
    background-color: #E6E6E6;
    margin: 3px;
	opacity: 0.95;
}
	#box_container {
	position: right;
	width: 535px;
	height: 10px;
	background-color: #fff;
	border: solid 1px #fff;
	margin: 00px 0px 5px 0px;
	opacity: 0.95
	}
	
	#cartesian_point_a{
	position:absolute;
	top: 0px;
	bottom: 00px
	left: 0px;
	color: #000;
	background-color: #fff;
	}

	div.box-contents {
	position: relative; padding: 8px; color:#000; opacity: 0.5
	}

div#menu 
{
  border:2px solid white;
  width: 19.25em;
  float:center; 
  margin:15px 0 10px 5px;
  height:50px;
}
-->
</style>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="assets/images/484a4f3fe9657271b717f834576bcca2eb683c27_m.gif" type="image/x-icon">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic&amp;subset=latin">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,700">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway:400,100,200,300,500,600,700,800,900">
  <link rel="stylesheet" href="assets/et-line-font-plugin/style.css">
  <link rel="stylesheet" href="assets/bootstrap-material-design-font/css/material.css">
  <link rel="stylesheet" href="assets/tether/tether.min.css">
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="assets/socicon/css/socicon.min.css">
  <link rel="stylesheet" href="assets/animate.css/animate.min.css">
  <link rel="stylesheet" href="assets/dropdown/css/style.css">
  <link rel="stylesheet" href="assets/theme/css/style.css">
  <link rel="stylesheet" href="assets/mobirise/css/mbr-additional.css" type="text/css">
<%
  Iterator itsOn = null; 
  String browserSessionID;  
  final int EmptyCartCount = 0;   
  Vector cashAcctVector = new Vector();
  StringBuffer hammer = new StringBuffer("");
  String cancelSessState = request.getParameter("cancel");
  
  session = request.getSession(true);
  browserSessionID = session.getId( );
  cashAcctVector = (Vector) session.getAttribute("CASH_ACCT_VECTOR");
      
  /*
  if(session.getAttribute("Identitat") == null && cashAcctVector==null) 
	  response.sendRedirect("identify.jsp");
  */
%>  
</head>

<body onload>
<section id="ext_menu-0">

    <nav class="navbar navbar-dropdown navbar-fixed-top">
        <div class="container">
            <div class="mbr-table">
                <div class="mbr-table-cell">
                    <div class="navbar-brand">
                        <a class="navbar-caption" href="grid.jsp">Uptown Lucidity</a>
                    </div>
                </div>
                <div class="mbr-table-cell">
                    <ul class="nav-dropdown collapse pull-xs-right nav navbar-nav navbar-toggleable-sm" id="exCollapsingNavbar"><li class="nav-item">
					<a class="nav-link btn btn-primary" href="index.jsp">root</a></li></ul>
                    <button hidden="" class="navbar-toggler navbar-close" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
                    </button>
                </div>
            </div>
        </div>
    </nav>
</section>

<section 
class="mbr-section mbr-section-hero mbr-section-full mbr-section-with-arrow mbr-after-navbar" 
id="header5-0" style="background-image: url(assets/images/money.talks.giphy.gif); padding-top: 120px; padding-bottom: 120px;">

    <div class="mbr-table-cell">
        <div class="container">
            <div class="row">
                <div class="mbr-section col-md-10">

				    <p id="demo" align="center">
					<font size=3 color="grey">Browser session: <%=browserSessionID%></font><br>
					<font size=3 color="white"><%=new java.util.Date(System.currentTimeMillis()).toString()%></font>					
					</p>
					
					<form method=POST id="thisform" onsubmit="return validate_form(this)" action="BlackSeaFloat/PublicServlet">
                    
					<TABLE class="tg" style WIDTH="30%" align="center">
					<TD align="center">
					<font size ="5" color="#F8FBFE">passcode<br></font>
					<INPUT TYPE="text" NAME="lucidInput" ID="lucidInput"size="8">					
					</TD>
					</tr>    
					</table>
					
					<table align=center>
					<tr align=center><td align=center>
					<INPUT type=hidden value="cashAcctManagement" id="zeit" name="cashAcctManagement">
	                <INPUT type=hidden value=yes name=cookiesetonlogin>					
					<div class="mbr-section-btn">
					<BR>
					<input type="submit" value="You Are Passing"  class="btn btn-lg btn-info">
					<br>
					<br>
					<div align="center" id="acctAvailable"><A HREF="index.jsp"><font color="white">Home?</div></A>
					
					</div>
					
					<br>					
					</td>
					<td>
					</td>
					</tr>
					</table>
					</form>
					
             </div>
            </div>
        </div>
    </div>

    

    <div class="mbr-arrow mbr-arrow-floating" aria-hidden="true"><a href="#next"><i class="mbr-arrow-icon"></i></a></div>

</section>


  <script src="assets/web/assets/jquery/jquery.min.js"></script>
  <script src="assets/tether/tether.min.js"></script>
  <script src="assets/bootstrap/js/bootstrap.min.js"></script>
  <script src="assets/smooth-scroll/SmoothScroll.js"></script>
  <script src="assets/viewportChecker/jquery.viewportchecker.js"></script>
  <script src="assets/dropdown/js/script.min.js"></script>
  <script src="assets/touchSwipe/jquery.touchSwipe.min.js"></script>
  <script src="assets/theme/js/script.js"></script>
  
  
  <input name="animation" type="hidden">
  </body>
</html>
<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="generator" content="Mobirise v3.6.3, mobirise.com">
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
  <link rel="stylesheet" href="assets/theme/css/style.css">
  <link rel="stylesheet" href="assets/mobirise/css/mbr-additional.css" type="text/css">
<div class="navbar-brand"><a href="index.jsp" class="navbar-logo"></a><a class="navbar-caption text-success" href="index.jsp">Geist</a></div>
<%

  String Time = null;
  String version = "1.5";
  String sessionId = null;
  sessionId = session.getId();
  long t = System.currentTimeMillis();	
  mod.ValueObject.Thug citizen = null;
  Time = new java.util.Date(t).toString(); 
  java.util.Enumeration userSessionElemements = null;
  System.out.println("\t<grid.jsp: "+Time+" sID: "+sessionId+" for "+version+">"); 
  
  if(session.getAttribute("THUG") == null)
  {
	  response.sendRedirect("identify.jsp");	  
  }
  else 
  {
	  citizen = (mod.ValueObject.Thug) session.getAttribute("THUG");
  }
  
  userSessionElemements = session.getAttributeNames();
  
  while(userSessionElemements.hasMoreElements())
  {
	System.out.println("\t<userSessionElemement: " + userSessionElemements.nextElement() +">");  
  }
  System.out.println();
  
%>      

<style type="text/css">
<!--
BODY {
background-image: url(assets/images/div-2.gif);
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
</head>
<body>
<section class="mbr-section mbr-section-hero mbr-section-full mbr-section-with-arrow">
    <div>
    <div class="container">
    <div class="row">
	<style type="text/css">
	table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
	}

	td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 24px;
	}

	tr:nth-child(even) {
    background-color: #dddddd;
	}
	</style>
                <div class="mbr-section col-md-10">
				<%
				java.lang.String myColor = "ffffff";
				java.lang.String myName = "";
				if(citizen != null ) 
				{
					myColor = citizen.getColor();
					myName = citizen.getCodename();	
					session.setAttribute("MY_COLOR", myColor);					
				}
				if(myName==null||myName.equals("")) myName = session.getId();
				%>
					<h1 class="mbr-section-title display-1">
					<font color="f8be8f">Hello,<br>
					<font color="ffffff" size=7><%=myName%><font color="white">.
					</font>
					
					</h1>

					<br>					

<table class="tg">
  <font color="f8bf8b">
  <tr>
    <td><font size ="3" color="ffffff"><A HREF="liability.jsp?"><font size ="6" color="ffffff">
        Credit</A><br><font size ="2">Debt and Expense
		</td>
    <td><font size ="3" color="<%=myColor%>"><A HREF="liquidity.jsp?"><font size ="6" color="f8be8f">
        Cash</A><br><font size ="2"><A HREF="currentInterpretation.jsp">Currency</A> On Hand
		</td>
<td><font size ="3" color="<%=myColor%>"><A HREF="castle.jsp?"><font size ="6" color="f8be8f">
        Castle</A><br><font size ="2"><A HREF="Manage1934INE.html">Quadraplex</A> 
		</td>		
    <td><font size ="3" color="ffffff"><A HREF="equities.jsp?"><font size ="6" color="ffffff">
        Capital</A><br><font size ="2">Warchest</font>
		</td>
    <td><font size ="3" color="ffffff"><A HREF="engagements.jsp?"><font size ="6" color="yellow">
        Clock</A><br><font size ="2">Itinerary
		</td>	
    <td><font size ="3" color="ffffff"><A HREF="/Sawa/inventory.jsp?"><font size ="6" color="blue">
        Consulting</A><br><font size ="2">Insights
		</td>		
  </tr>    
  </font>
</table>
<br>
					
                    <div class="mbr-section-btn">
					<a class="btn btn-lg btn-info" href="ownerLogout.jsp">LOGOUT</a>
					</div>
					</div><font size ="2" color="white">
					This page last loaded: <%=Time%>
					</font>
					
					<h3 class="mbr-section-title display-1">
					<font size="3" color="ffffff">
					<A HREF="resources.jsp?">
					system resources</A>
					</font>
					</h3>
					
                </div>
            </div>
        </div>
    </div>

    <div class="mbr-arrow mbr-arrow-floating" aria-hidden="true"><a href="#next"><i class="mbr-arrow-icon"></i></a></div>

</section>


  <section class="engine"><a rel="external" href="https://mobirise.com">best web site generator software</a></section><script src="assets/web/assets/jquery/jquery.min.js"></script>
  <script src="assets/tether/tether.min.js"></script>
  <script src="assets/bootstrap/js/bootstrap.min.js"></script>
  <script src="assets/smooth-scroll/SmoothScroll.js"></script>
  <script src="assets/viewportChecker/jquery.viewportchecker.js"></script>
  <script src="assets/theme/js/script.js"></script>
  
  
  <input name="animation" type="hidden">
  </body>
</html>
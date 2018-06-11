<%/*SELECT * FROM Engagements WHERE start_date LIKE "2017-08-11";*/%>
<!DOCTYPE html>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="mod.Utility.*" %>
<%@ page import="mod.ValueObject.*" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="assets/images/484a4f3fe9657271b717f834576bcca2eb683c27_m.gif" type="image/x-icon">
  <meta name="description" content="">
  
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
  <style type="text/css">
<!--
BODY {
background-image: url(/Geist/assets/images/astro-giphy.gif);
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
	border-spacing: 1px;
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
    margin: 1px;
	opacity: 0.95;
}

	div.box-contents {
	position: relative; padding: 8px; color:#000; opacity: 0.5
	}

-->
</style>

  
<script type="text/javascript">
function init()
{
	window.setInterval("getTime()",1000);

	if( document.getElementById("lockButton").value == 'Update')
	{
		alert(document.getElementById("lockButton").value);
		
		document.getElementById("button").disabled=false;
		
		return;
	}
	else
	{
		document.getElementById("button").disabled=true;
	}
	
  return;	
}


function getTime()
{
	var url = "Geist/BlackServerTime";
	
	if(window.ActiveXObject)
	{
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if(window.XMLHttpRequest)
	{
		request = new XMLHttpRequest();
	}

	request.onreadystatechange = showTime;
	request.open("POST",url,true);
	request.send();
}

function showTime()
{

	if(request.readyState == 4)
	{
		var response = request.responseText;
		document.getElementById("TimeH1").innerHTML = response;
		document.getElementById("TimeH1").className = "timing";		
		document.getElementById("TimeH1").value = response;	
	}
}


</script>  
 <%
 String scopeColor = "yellow";
 %> 
  
</head>
<BODY onload="init();">

<div class="mbr-section col-md-10">
<%
  int maxRows = 10;
  int eventCount = 0;
  Connection conn = null;
  StringBuffer tbl = null;
  ResultSet results = null; 
  Statement selectMessages = null; 
  
  boolean done = false;
  int ID = 0; 
  String DB = null; 
  String USER = null; 
  Integer TIME = null;
  String INFO = null;   
  String STATE = null;   
  String COMMAND = null; 
  
  String endTime = null; 
  String endDate = null; 
  String startDate = null;
  String startTime = null;   
  String periodType = null; 
  String activityType = null;
  String RecordHasDetail = ""; 
  String engagementDescrip = null;    
  String RecordHasUsers  = "root";   
  String sessionId = session.getId();    
  long t = System.currentTimeMillis();	
  String calendarDate = new java.sql.Date(t).toString();
  String mColor = (String)session.getAttribute("MY_COLOR");	   
  mod.Utility.Cloudtime iCloudtime = new mod.Utility.Cloudtime( );
  String RecordHasLocation = "jdbc:mysql://localhost:3306/quatrarian?serverTimezone=UTC";  
  if(session.getAttribute("THUG") == null) response.sendRedirect("identify.jsp"); 
  String RecordHasElements = "SELECT COUNT(*) FROM information_schema.PROCESSLIST WHERE db =\"quatrarian\" AND HOST LIKE \"localhost\"";	
  String ResourceElements = "SELECT * FROM information_schema.processlist GROUP BY host;";
  try
   	{
		RecordHasDetail = "";
		tbl = new StringBuffer();	    
		tbl.append(RecordHasDetail);
		//http://java-source.net/open-source/connection-pools
		//https://stackoverflow.com/questions/269979/how-to-count-open-db-connections
		//https://vladmihalcea.com/the-best-way-to-detect-database-connection-leaks/
		Class.forName("com.mysql.jdbc.Driver");  
		conn = DriverManager.getConnection(	RecordHasLocation, RecordHasUsers,"Inf0rmation"	);

    	selectMessages = conn.createStatement( );
		results = selectMessages.executeQuery(ResourceElements);
		Timestamp ttday = new Timestamp(System.currentTimeMillis());

		while(results.next())
	  	{          
		  ID = results.getInt("ID");
		  DB = results.getString("DB");
		  USER = results.getString("USER");
		  TIME = results.getInt("TIME");
		  INFO = results.getString("INFO");
		  STATE = results.getString("STATE");
		  COMMAND = results.getString("COMMAND");
		  eventCount++ ;
		  
		  if(calendarDate.equals(startDate)) 
			  mColor = "green";
		  
		  tbl.append("<td>&nbsp;&nbsp;");
		  tbl.append("</td>");

		  tbl.append("<tr>");
		  tbl.append("<td><font size =\"4\" color=\"blue\">");
		  tbl.append(ID);		  
		  tbl.append("</td>");	 
	  
		  tbl.append("<td><font size =\"4\" color=\"blue\">");
		  tbl.append(DB);		  
		  tbl.append("</td>");
		  
		  tbl.append("<td><font size =\"4\" color=\"blue\">");
		  tbl.append(USER);		  
		  tbl.append("</td>");	 
		  
		  tbl.append("<td><font size =\"4\" color=\"blue\">");
		  tbl.append(TIME.toString());		  
		  tbl.append("</td>");	 
	  
		  tbl.append("<td><font size =\"4\" color=\"blue\">");
		  tbl.append(INFO);		  
		  tbl.append("</td>");
		  
		  tbl.append("<td><font size =\"4\" color=\"blue\">");
		  tbl.append(STATE);		  
		  tbl.append("</td>");	 
	  
		  tbl.append("<td><font size =\"4\" color=\"blue\">");
		  tbl.append(COMMAND);		  
		  tbl.append("</td>");
		  tbl.append("</tr>");	
		  
		 if(eventCount == maxRows) break;
   		}
		
    } 
    catch (Exception eExecute)
    {
		eExecute.printStackTrace() ;
    }
	finally 
    {
		session.setAttribute("Engagements", null);
		
		try{results.close();
        }catch(Exception ignored){}
		try{selectMessages.close();
        }catch(Exception ignored){}
		try{conn.close();
        }catch(Exception ignored){}
	}

%>  
<h1 class="mbr-section-title display-1">
					<div class="navbar-brand">
                    </div>

<style type="text/css">
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 85%;
}

td, th {
    border: 0px solid #dddddd;
    text-align: left;
    padding: 0px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
    <nav class="navbar navbar-dropdown bg-color transparent navbar-fixed-top">
        <div class="container">
        <a href="grid.jsp" class="navbar-logo">
        <a class="navbar-caption text-success" href="grid.jsp"><font color="0080ff">Geist</font></a>
        </div>
		</div>
		<font size ="2" color="0080ff">
					This page last loaded: <%=calendarDate%>
		</font>
			<h3 class="mbr-section-title display-1">
	<font size="3" color="ffffff">
	Java<A HREF="Geist/HeadGear">Stats</A>
	</font>
	</h3>

        </div>
        </div>
        </div>
    </div>
	<INPUT class=input align=center id="TimeH1" ReadOnly STYLE="font-family:sans-serif; font-size:small;
	background:#5C5858 none; color:#fff; width:13.5em">
 <table class="tg">
  <%=tbl.toString()%>
  </table>
  <BR>
                    <TABLE>
					<TR>

					</TR>
					</TABLE>
  <BR>					
</body>


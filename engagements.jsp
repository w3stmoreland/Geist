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
background-image: url(/Geist/assets/images/Favim.com-33473.jpg);
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
  String todayColor = "white";
  Statement selectMessages = null; 
  
  boolean done = false;
  boolean tday = false;
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
  String RecordHasElements = "SELECT * FROM Engagements WHERE accomplished < 1 ORDER BY start_date DESC ;"; 
		
  
  try
   	{
		RecordHasDetail = "";
		tbl = new StringBuffer();	    
		tbl.append(RecordHasDetail);
		Class.forName("com.mysql.jdbc.Driver");  
		conn = DriverManager.getConnection(	RecordHasLocation, RecordHasUsers,"Inf0rmation"	);

    	selectMessages = conn.createStatement( );
		results = selectMessages.executeQuery(RecordHasElements);
		Timestamp ttday = new Timestamp(System.currentTimeMillis());

		while(results.next())
	  	{          
		  int eID = results.getInt("engagement_ID");
		  startDate = results.getDate("start_date").toString();
		  startTime = results.getString("start_time");
		  periodType = results.getString("period_type");
		  engagementDescrip = results.getString("engagement_descript");
		  endDate = results.getString("end_date");
		  done = results.getBoolean("accomplished");
		  
		  eventCount++ ;
		  
		  if(calendarDate.equals(startDate)) 
			  mColor = "green";
		  
		  tbl.append("<td>&nbsp;&nbsp;");
		  tbl.append("</td>");
		  
		  tbl.append("<tr>");
		  tbl.append("<td><font size =\"6\" color=\"white\">");
		  tbl.append("<A HREF=engagements.jsp?Parmesean=" + eID + ">");
		  tbl.append(eID + "</A>");		  
		  tbl.append("</td>");
		  
		  tbl.append("<td><font size =\"3\"" + mColor );
		  tbl.append("<font size =\"4\" color=\""+ (String)session.getAttribute("MY_COLOR")+ "\">"+startDate+"</A></font>");
		  tbl.append("</td>");
		  
		  /**/
		  tbl.append("<td><font size =\"2\"" + mColor );
		  tbl.append("<font size =\"2\" color=\"808080\">" + iCloudtime.whatDayOfTheWeek(startDate)+"</A></font>");
		  tbl.append("</td>");		  
		  
		  tbl.append("<td><font size =\"2\" color=\"white\">");
		  tbl.append("<font size =\"4\" color=\"white\">"+startTime+"</A></font>");
		  tbl.append("</td>");
		  
		  tbl.append("<td><font size =\"2\" color=\"white\">");
		  tbl.append("<font size =\"3\" color=\""); 
		  //tbl.append(mColor);
		  tbl.append("black");		  
		  tbl.append("\"> " + engagementDescrip + "</A></font>" );
		  tbl.append("</td>");
		   
		   	if( iCloudtime.isTodayTheDay( Cloudtime.getDate( endDate, true ) ) )
				todayColor = "3cc47c";
			else todayColor = "white";
			
		  tbl.append("<td><font size =\"2\" color=\"white\">");
		  tbl.append("<font size =\"3\" color=\"" + todayColor + "\">" + endDate + "</font>" );
		  tbl.append("</td>");
		  
		  tbl.append("<td><font size =\"2\" color=\"white\">");
		  tbl.append("<font size =\"3\" color=\""+ (String)session.getAttribute("MY_COLOR")+ "\">"+periodType+"</A></font>");
		  tbl.append("</td>");	
		  
		  if(done)
		  {
		  tbl.append("<td><font size =\"2\" color=\"green\">");
		  tbl.append("<font size =\"3\" color=\"green\">done</font>");
		  tbl.append("</td>");			  
		  } else {
		  tbl.append("<td><font size =\"2\" color=\"white\">");
		  tbl.append("<A HREF=engagementStateManagement.jsp?ID="+eID+">status</A></font>");
		  tbl.append("</td>");					  
		  }
		  
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
		try{
			
			conn.close();			
			if(!conn.isClosed()) conn.close();			
			conn = null ;
			
			System.out.println("\n\t(calendar) Conn is done\n");
        }
		catch(Exception ignored)
		{
			System.out.println("\n\tThe Connection is not closing...?!?\n");
		}
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
					<TD><a class="btn btn-lg" href="affix.jsp"><font size="3">Add One Event</font></a></TD>
					<TD><a class="btn" href="retire.jsp"><font size="3" color="white">Drop One Event</font></a></TD>
					</TR>
					</TABLE>
  <BR>					
</body>


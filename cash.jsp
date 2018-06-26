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
background-image: url(assets/images/loop-infinite-x.gif);
font-size: 16px;
	font-family: Georgia;
    background-repeat: no-repeat;
    no-repeat center fixed; 
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
  border:2px solid grey;
  width: 19.25em;
  float:center; 
  margin:15px 0 10px 5px;
  height:50px;
}
-->
</style>
</head>
<body>
<%
  int mCount = 0;
  Integer acct = null;
  Double  deposit = null;
  Connection conn = null;
  StringBuffer tbl = null;
  String  balanceDate = "";
  ResultSet results = null;
  Double  depositDescr = null;
  String RecordHasDetail = "";  
  Statement selectMessages = null;  
  String RecordHasUsers  = "root";   
  String sessionId = session.getId();    
  long t = System.currentTimeMillis();	
  java.util.Vector cashAccountVector = null;
  String Time = new java.util.Date(t).toString();
  ApproximatedCashBalance approximateCashBalance = null;
  String mColor = (String)session.getAttribute("MY_COLOR");	  
  String RecordHasLocation = "jdbc:mysql://localhost:3306/quatrarian";   
  System.out.println("\t<cash.jsp: "+Time+" sID: "+sessionId+">"); 
  
  String RecordHasElements = "SELECT acct_ID, deposit_in_usd, Date(balance_date_time) "+
				"FROM balances WHERE deposit_in_usd > 0.00 ORDER BY deposit_in_usd DESC;"; 
     
  if(session.getAttribute("THUG") == null) response.sendRedirect("identify.jsp");

  try
   	{
		RecordHasDetail = "";
		tbl = new StringBuffer();	    
		tbl.append(RecordHasDetail);
        cashAccountVector = new Vector();
        depositDescr = new Double("0.0");		
		
		conn = DriverManager.getConnection(RecordHasLocation, RecordHasUsers,"Inf0rmation");

    	selectMessages = conn.createStatement( );
		results = selectMessages.executeQuery(RecordHasElements);
		Timestamp ttday = new Timestamp(System.currentTimeMillis());

		while(results.next())
	  	{          
		  acct = new Integer(results.getInt("acct_ID"));
		  deposit = new Double(results.getString("deposit_in_usd"));
		  balanceDate = results.getString("Date(balance_date_time)");
          depositDescr +=  deposit;
          
          approximateCashBalance = new ApproximatedCashBalance(acct, deposit, balanceDate) ;
          cashAccountVector.add(approximateCashBalance);

         if(mCount % 2 == 0)
         {
             mColor = "color=\"black\">";	
         }
		  
		  tbl.append("<tr>");
		  tbl.append("<td><font size =\"3\"" + mColor );
		  tbl.append("<A HREF=updateAcctBalance.jsp?originAccountParm=" + acct + "><font size =\"4\" color=\""+ 
		  (String)session.getAttribute("MY_COLOR")+ "\">"+acct+"</A></font>");
		  tbl.append("</td>");
		  
		  tbl.append("<td><font size=\"4\"" + mColor );
		  /*tbl.append("<A HREF=createAcctDeposit.jsp?acct_into_arg=" + acct + ">" +*/
		  tbl.append("<B>" + USDollars.GetDollarDescription(approximateCashBalance.getBalanceInDollars().toString()) +"</B>");
		  /*+"</A>");*/
		  tbl.append("</td>");

		  tbl.append("<td><font size =\"4\"" + mColor );
		  tbl.append(balanceDate);
		  tbl.append("</td>");		  
	  
          mColor = "color=\"white\">";	
		  tbl.append("</tr>");	          
		  mCount ++;
 		}
		
        session.setAttribute("CASH_ACCT_VECTOR", cashAccountVector );
    } 
    catch (Exception eExecute)
    {
		
		eExecute.printStackTrace() ;
    }
	finally 
    {
		response.sendRedirect("identify.jsp");
		try{results.close();
        }catch(Exception ignored){}
		try{selectMessages.close();
        }catch(Exception ignored){}
		try{conn.close();
        }catch(Exception ignored){}
	}

	session.setAttribute("ApproximatedCashBalance", depositDescr);	
%>      
 
<section id="page15-menu-0">

    <nav class="navbar navbar-dropdown bg-color transparent navbar-fixed-top">
        <div class="container">
            <div class="mbr-table">
                       <div class="navbar-brand">
                        <a href="grid.jsp" class="navbar-logo">
                            <img src="assets/images/4afea0a2a71d33b9e6b2fb7db2f973641d7e233e-m-127x128-1.jpg" alt="Mobirise"></a>
                        <a class="navbar-caption text-success" href="grid.jsp">Geist</a>
                    </div>
            </div>
        </div>
    </nav>

</section>

<section class="mbr-section mbr-parallax-background mbr-after-navbar" id="liability-content5-0">

           <div class="container">
					<%
					if(mCount>0)
					{%>
					<h1 class="mbr-section-title display-1">
					<font color="grey">Cash <font color="black"><%=RecordHasUsers%></font> <font color="grey">
                    everything around me<font color="grey">.</font>

                    <BR>
                    <font color="white" size=5>
                    <%=mCount%> accts <font color="white">&nbsp;&nbsp
                    <%=USDollars.GetDollarDescription(depositDescr)%>
                    &nbsp;&nbsp;&nbsp;&nbsp; 
                    Back to 
                    <A HREF="grid.jsp">Grid</A>.
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    Modify 
                    <A HREF="cashAcctManagement.jsp">accts</A>.
                    <BR>
                    </font>
					</h1>
                    
					<%
					} 
					else 
					{
					%>
					<h1 class="mbr-section-title display-1">
					<font color="f8be8f">There are no messages, yet, 
                        <font color="ffffff"><%=RecordHasUsers%><font color="f8be8f">.</font>
					</h1>
					<%
					}  
					%>

    </div>

<style type="text/css">
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}

</style>

<table class="tg">
  <tr>
  <th class="tg-yw4l">
  <font color="grey">
  Acct</th>

  <th class="tg-yw4l">
  <font color="grey">
  Deposit</th>
  
  <th class="tg-yw4l">
  <font color="grey">
  Date</th>  
 </tr>

  <font color="white">
  <%=tbl.toString()%>
  </font>
  
</table>

</section>


  <script src="assets/web/assets/jquery/jquery.min.js"></script>
  <script src="assets/tether/tether.min.js"></script>
  <script src="assets/bootstrap/js/bootstrap.min.js"></script>
  <script src="assets/smooth-scroll/SmoothScroll.js"></script>
  <script src="assets/viewportChecker/jquery.viewportchecker.js"></script>
  <script src="assets/jarallax/jarallax.js"></script>
  <script src="assets/dropdown/js/script.min.js"></script>
  <script src="assets/touchSwipe/jquery.touchSwipe.min.js"></script>
  <script src="assets/theme/js/script.js"></script>
  
  
  <input name="animation" type="hidden">
  </body>
</html>
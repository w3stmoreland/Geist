<!DOCTYPE html>
<html>
<%@ include file="dbEval.jsp" %>
<BR>
<BR>
<head>
<script type="text/javascript">
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
	  if (validate_required(Form_Profile_UserName,"Please choose a User name to submit.")==false)
  	  {
	   Form_Profile_UserName.focus();
	   return false;
      }
	  
	  if (validate_required(Form_Profile_PWD,"Please choose a Password to submit.")==false)
  	  {
	   Form_Profile_PWD.focus();
	   return false;
      }	  
  }
  
}
</script>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="generator" content="Mobirise v3.6.3, mobirise.com">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="assets/images/4afea0a2a71d33b9e6b2fb7db2f973641d7e233e-m-127x128-1.jpg" type="image/x-icon">
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
</head>
<body>

<%
int sanityCheck = 3;
boolean isConnected = false;
boolean unReachable = false;
String sanityString = "DB Error";   
%>
<section id="page13-menu-0">
    <nav class="navbar navbar-dropdown bg-color transparent navbar-fixed-top">
        <div class="container">
            <div class="mbr-table">
                <div class="mbr-table-cell">

                    <div class="navbar-brand">
                        <a href="index.jsp" class="navbar-logo">
						<img src="assets/images/4afea0a2a71d33b9e6b2fb7db2f973641d7e233e-m-127x128-1.jpg" alt="Mobirise"></a>
                        <a class="navbar-caption text-success" href="index.jsp">Geist</a>

                    </div>

                </div>
                <div class="mbr-table-cell">
                    <button class="navbar-toggler pull-xs-right hidden-md-up" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
                        <div class="hamburger-icon"></div>
                    </button>

                    <ul class="nav-dropdown collapse pull-xs-right nav navbar-nav navbar-toggleable-sm" id="exCollapsingNavbar">
					<li class="nav-item dropdown"><a class="nav-link link dropdown-toggle" data-toggle="dropdown-submenu" href="https://mobirise.com/" aria-expanded="false">FEATURES</a><div class="dropdown-menu"><a class="dropdown-item" href="https://mobirise.com/">Mobile friendly</a><a class="dropdown-item" href="https://mobirise.com/">Based on Bootstrap</a><div class="dropdown"><a class="dropdown-item dropdown-toggle" data-toggle="dropdown-submenu" href="https://mobirise.com/">Trendy blocks</a><div class="dropdown-menu dropdown-submenu"><a class="dropdown-item" href="https://mobirise.com/">Image/content slider</a><a class="dropdown-item" href="https://mobirise.com/">Contact forms</a><a class="dropdown-item" href="https://mobirise.com/">Image gallery</a><a class="dropdown-item" href="https://mobirise.com/">Mobile menu</a><a class="dropdown-item" href="https://mobirise.com/">Google maps</a><a class="dropdown-item" href="https://mobirise.com/">Social buttons</a><a class="dropdown-item" href="https://mobirise.com/">Google fonts</a><a class="dropdown-item" href="https://mobirise.com/">Video background</a></div></div><a class="dropdown-item" href="https://mobirise.com/">Host anywhere</a></div></li><li class="nav-item dropdown"><a class="nav-link link dropdown-toggle" data-toggle="dropdown-submenu" href="https://mobirise.com/">HELP</a><div class="dropdown-menu"><a class="dropdown-item" href="http://forums.mobirise.com/">Forum</a><a class="dropdown-item" href="https://mobirise.com/">Tutorials</a><a class="dropdown-item" href="https://mobirise.com/">Contact us</a></div></li></ul>
                    <button hidden="" class="navbar-toggler navbar-close" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
                        <div class="close-icon"></div>
                    </button>

                </div>
            </div>

        </div>
    </nav>

</section>

<section class="engine"><a rel="external" href="https://mobirise.com">best bootstrap site builder</a></section>
<section class="mbr-section mbr-parallax-background mbr-after-navbar" id="liability-content5-0" 
         style="background-image: url(assets/images/astro-giphy.gif); padding-top: 120px; padding-bottom: 120px;">
    <div class="mbr-table-cell">
    <div class="container">
            <div class="row">
                <div class="mbr-section col-md-10">
				
				<h1 class="mbr-section-title display-1">
				<font color="grey">Identify Yourself</font></h1>
						<% String bw = blackWire.getSocketHost();%>
						<font size="2" color="black"><%=bw%></font>
				</font>

				<FORM action="Geist/SuperThug" id="thisform" onsubmit="return validate_form(this)"  method=POST>
					
					<font color="white" size="5">user name:</font>
					<input type="text" 	name=Form_Profile_UserName 
					placeholder="user name" />
					<br/> 
					
					<font color="white" size="5">password:</font>					
					<input type="password" name=Form_Profile_PWD 
					placeholder="password" />
					<br/> 
					
					<font color="black">
					<BR>
					<a class="btn btn-lg btn-info" 		href="identify.jsp?cancel=true">CANCEL</a> 
					<input type="submit" value="LOGIN" class="btn btn-lg btn-white btn-white-outline"/>
					
				
				</FORM>
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
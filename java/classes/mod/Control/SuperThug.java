package mod.Control;

import java.util.*;
import mod.Utility.*; 
import mod.ValueObject.*;
import java.io.*;
import java.sql.*;
import javax.naming.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.*;
 
/*
 * "... I'm with the boss, right now...'"
 */
@WebServlet("/Geist/SuperThug")
public class SuperThug extends HttpServlet {

// The datasource;
private DoTheKnowledge dm;

// The database config;
private InputStream inputStream;

private static String APP_ROOT;

private static String USER_MENU;

private static String NEW_USER_MENU;

private static String DEBUG_CONTEXT;

private static String RESOURCE_STREAM;

private static final long serialVersionUID = 1L;

private final String LAST_GATED_PAGE="LAST_GATED_PAGE";

private final String Form_Profile_PWD="Form_Profile_PWD";

private final String Form_Profile_UserName="Form_Profile_UserName"; 


public void destroy() {
	try{
	this.inputStream.close();
	this.inputStream = null;
	dm = null;
	}catch( Exception e ){
		e.printStackTrace();
	}
	
return; 
} 

/**
* The method plan:  "vectors.jsp "

* The user is routed to login for pages that are "GATED".
*/

            
/**
     * Results in a user URL path -- using the supplied object instances.
	 * Users need to have credentials and a place to be.
     *
     * @param userRequest maps the request details and may not be null.	 
     * @return pageAccessEvent redirect URL;
     */
private String validUserOntology( HttpServletRequest userRequest ){
	String pageAccessEvent = "";
	jotted("[SuperThug.validUserOntology]");
	String _PassWord = (String)userRequest.getParameter(Form_Profile_PWD);
	if(_PassWord!=null&&!_PassWord.trim().equals("")) jotted("[_PassWord] " + _PassWord.hashCode());
	String _UserName = (String)userRequest.getParameter(Form_Profile_UserName);
	if(_UserName!=null&&!_UserName.trim().equals("")) jotted("[_UserName] " + _UserName.hashCode());
	String getUserRequestURL = (String) userRequest.getSession().getAttribute(LAST_GATED_PAGE);
    if(getUserRequestURL!=null) 
	{
		jotted("[getUserRequestURL] " + getUserRequestURL.hashCode());
		pageAccessEvent = "/"+getUserRequestURL;
	}
    return pageAccessEvent;
}


public void init( ServletConfig config ) throws ServletException {
super.init(config);
jotted("[SuperThug.init]");
long configBytesAvailable = 0L;
APP_ROOT = config.getInitParameter("APP_ROOT");
USER_MENU = config.getInitParameter("USER_MENU");
NEW_USER_MENU = config.getInitParameter("NEW_USER_MENU");
DEBUG_CONTEXT = config.getInitParameter("DEBUG_CONTEXT");
RESOURCE_STREAM = config.getInitParameter("RESOURCE_STREAM");
inputStream = this.getServletContext().getResourceAsStream(RESOURCE_STREAM);

if(inputStream != null)
{
  try{

	dm = new DoTheKnowledge();
	configBytesAvailable = inputStream.available();
	DoTheKnowledge.assignProperties(inputStream);

      if(configBytesAvailable>0) 
  	  {
	    if(DEBUG_CONTEXT.equals("TRUE"))
  	    jotted("RESOURCE_STREAM BytesAvailable: " + configBytesAvailable ) ;
		}
		
  }catch( Exception e ) { e.printStackTrace(); }
}

jotted("[SuperThug, App Root Everything Around Me, "+APP_ROOT+"]");
jotted("[SuperThug, RESOURCE_STREAM, "+RESOURCE_STREAM+"]");
jotted("[SuperThug, DEBUG_CONTEXT, "+DEBUG_CONTEXT+"]");
jotted("[SuperThug, USER_MENU, "+USER_MENU+"]");
jotted("[init returns]");
return;
}


private static void jotted(String msg, Object... args) {
  System.out.println("\t<"+String.format(msg, args)+"> ");
  return;
} 

/**
     * Method constructs a mod.ValueObject.Thug with the expected credential request parameters.
     * The side effect is the login and validation of the "mod.ValueObject.Thug" instance.
	 * 
     * @param request is the map of user form details and may not be null.	 
     * @param response  map of user server direction and may not be null.	
	 * @return pageAccessEvent redirect URL;
     */
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String thugForward = "";  

	jotted("[SuperThug.doPost]") ;
	/*
	 There is a session, 
	 but is there a user?
	 */
	boolean loginIdentified = false;	
	
	mod.ValueObject.Thug thugIdentity = null;
	
	ThuggedOutAccess thuggedOutAccess = null;		   	  
	
	String _PassWord = (String)request.getParameter(Form_Profile_PWD);
	
	String _UserName = (String)request.getParameter(Form_Profile_UserName);
	
	try {

  	  DoTheKnowledge.getConnectionCount();

	  thuggedOutAccess = new ThuggedOutAccess();
	
	  	if( hasValidFormName( _UserName ) == false )
      	{
			thugForward = NEW_USER_MENU ;

			if(thugForward!=null) jotted(
				"SuperThug.doPost is "+thugForward+" valid, " + loginIdentified
				) ;

      	} else {

			thugForward = USER_MENU ;

			thugIdentity = evaluatePublicIdentity( request ) ;

			loginIdentified = thuggedOutAccess.matchUserCredentials( 
				thugIdentity.getCodename(), 
				thugIdentity.getPassword() 
				);
	    	
			// Not heading anywhere;
			
			//if(validUserOntology(request).trim().equals(""))
			thugForward = USER_MENU +"?rWho=" +thugIdentity.getCodename();
			//else thugForward = validUserOntology(request);
	  	}
	  
    } 
	catch (Exception ex) 
	{
      System.err.println(ex);
    }
	
	/*Null, Never, Nobody, Negative, Zero and False*/
	String noWhere = APP_ROOT+"/"+thugForward;
	RequestDispatcher requestDispatcher = request .getRequestDispatcher(noWhere);
	jotted( "Session THUG: "+ thugIdentity );
	System.out.println( "\tTHUG OUT: " +noWhere);
	if(thugForward.indexOf("http") > 0 )  noWhere = thugForward;
	response.sendRedirect(noWhere);
	return;
}


protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/Quatrarian");
            Connection conn = ds.getConnection();
             
            Statement statement = conn.createStatement();
            String sql = "select user_name, email from owners";
            ResultSet rs = statement.executeQuery(sql);
             
            int count = 1;
            while (rs.next()) 
			{
                writer.println(String.format("User #%d: %-15s %s", count++,
                 rs.getString("user_name"), rs.getString("email")));
                 
            }
        } 
		catch (NamingException ex) 
		{
            System.err.println(ex);
        } 
		catch (SQLException ex) 
		{
            System.err.println(ex);
        }

     return; 
    }


//PRE: There are no matching identities in the database table; 
//OPERATE:
//POST:
private mod.ValueObject.Thug evaluatePublicIdentity( HttpServletRequest request ){
System.out.println("\n\t<SuperThug.evaluatePublicIdentity>");
mod.ValueObject.Thug publicID =	new mod.ValueObject.Thug();
String F_Profile_Passcode = (String)request.getParameter(Form_Profile_PWD);	
String F_Profile_UserName = (String)request.getParameter(Form_Profile_UserName);

if(F_Profile_Passcode!=null){
	publicID.setPassword(F_Profile_Passcode.trim());
}else {
    System.out.println("\n\tSuperThug found a Null password.");
	return publicID;
}

if(F_Profile_UserName!=null){
	publicID.setCodename(F_Profile_UserName.trim());
}else {
    System.out.println("\n\tSuperThug found a Null user id.");
	return publicID;
}

publicID.setCreateDate(new java.sql.Date(getLocalSystemTime())) ;
request.getSession().setAttribute("THUG",publicID);
publicID.setColor("#000000") ;
return publicID;
}


private long getLocalSystemTime(){	
long tranxDateTime = 0 ;
GregorianCalendar currentCalendar = new java.util.GregorianCalendar();
tranxDateTime = currentCalendar .getTime().getTime();
return tranxDateTime;
}


private boolean hasValidFormName( String userNameField ){
		boolean validStringFlag = true;

		if(userNameField == null || userNameField.equals("")) return false;

		if(userNameField==null||userNameField.equals("")||userNameField.trim().equals("")||userNameField.equals("username"))
    	{
			validStringFlag = false;
    	}
    	else if(userNameField!=null)
    	{
	    	validStringFlag = true;
    	}
    	
		return validStringFlag;		
	}

};
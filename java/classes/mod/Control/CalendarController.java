package mod.Control;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import mod.Utility.*;
import javax.servlet.*;
import mod.Utility.*;
import mod.ValueObject.*;
import javax.servlet.http.*;

public class CalendarController extends HttpServlet 
{
    private static final 
    long serialVersionUID = 1L;    

    private static String VERSION = ""; 
    private static String APP_ROOT = "";    
    private static String USER_MENU = "";
    private static String ADMIN_STATUS = "";
    mod.ValueObject.Engagement engagement = null;
    private EngagementAccessObject engagementAccessObject = null;
    private mod.ValueObject.Thug NullThug = new mod.ValueObject.Thug( );
   
    public void init( ServletConfig config ) throws ServletException {

	  super.init(config);

      System.out.println( "\t<CalendarController instantiated: "+ Cloudtime.getTimeStamp() +">" );

	  InputStream inputStream = this.getServletContext().getResourceAsStream("/WEB-INF/properties/rojo.properties");
	
		if(inputStream != null)
		{
            this.engagementAccessObject = new EngagementAccessObject(inputStream);
		}		
        else
        {
            System.out.println( "\t<CalendarController is not instantiated>" );
        }		

      VERSION = config.getInitParameter("VERSION");

	  APP_ROOT = config.getInitParameter("APP_ROOT");

      return ;
	}


    private mod.ValueObject.Thug getThugFromSession( HttpSession ses ){
       mod.ValueObject.Thug g = null;
       g = (mod.ValueObject.Thug) ses.getAttribute("THUG");
       if( g.equals( NullThug )) return NullThug ;
       return g;
    }
    

    private boolean hasValidFormName( String userNameField )
	{
		boolean validStringFlag = true;
		
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

	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
    	String forward = "";  
        Thug who = null;      
        String units = null;          
	    String activity = null;  
	    String timePicked = null;   
	    String description = null;  
        int engagementEvidence = 0; 
        String engagementState = "" ;                  
        java.lang.String endDatePicked = null;  
        java.lang.String startDatePicked = null;          
        mod.ValueObject.Engagement engagement = null;
        who = getThugFromSession(request.getSession());  

        engagementState = (String)request.getParameter("_EngagementState");

        try{
            if(engagementState.equals("yes")) 
            {
                // Change the database table;
                setCompleteEngagement( request, response, who );
                // Change the database table;
                setDeleteEngagement( request, response, who );
                // Change the database table;
                //--setUpdateEngagement( request, response, who );       
                response.sendRedirect(APP_ROOT+"/engagements.jsp"); 
                return;
             }
        }
        catch( Exception e )
        {
            e.printStackTrace();
        }

        units = (String)request.getParameter("_units");          
	    activity = (String)request.getParameter("_Activity"); 
        timePicked = (String)request.getParameter("_TimePicker"); 
        description = (String)request.getParameter("_Description");   
        endDatePicked = (String)request.getParameter("_EndDatePicker"); 
	    startDatePicked = (String)request.getParameter("_StartDatePicker");        
        System.out.println("\n\t<CalendarController for "+who.getCodename()+" identity.>\n");	         
        System.out.println("\n\t<StartDate: "+(String)request.getParameter("_StartDatePicker")+">\n");
        System.out.println("\n\t<EndDate: "  +(String)request.getParameter("_EndDatePicker") +">\n");            
        startDatePicked = Cloudtime.formatDateForTuple(startDatePicked);
        endDatePicked = Cloudtime.formatDateForTuple(endDatePicked);

        engagement = new mod.ValueObject.Engagement(
            who.getCodename(), timePicked, startDatePicked, activity, description
            );

        engagement.setEndDate(endDatePicked);

        engagementEvidence = this.engagementAccessObject.createUserObligation(
            engagement, who.getCodename()
            ) ;

        response.sendRedirect(APP_ROOT+"/engagements.jsp");            
    	return ;
    }
     
    
    private String getRequestedContext( HttpServletRequest req )
	{
	String theRequestedContext = "" ;
	String serverName = req.getServerName();
	int portNumber = req.getServerPort();
	String contextPath = req.getContextPath();
	theRequestedContext = serverName + ":" +portNumber + contextPath;
	return theRequestedContext ;
	}
	

    private int setCompleteEngagement( HttpServletRequest request, HttpServletResponse response, mod.ValueObject.Thug realG )throws ServletException, IOException {
        int complete = -1;
        Integer ID = null;
        String DeleteUpdateComplete = "";
        String CompleteState = "Complete";
        System.out.println("\t<setCompleteEngagement>\n");
        ID = new java.lang.Integer((String)request.getParameter("_eID"));
        DeleteUpdateComplete = (String)request.getParameter("_DeleteUpdateComplete");  
   
        if(CompleteState.equals(DeleteUpdateComplete))
        complete = this.engagementAccessObject.completeUserObligation( realG, ID ); 

        System.out.println("\t<DeleteUpdateComplete: "+DeleteUpdateComplete+", "+complete+">\n");   
        return complete;
    }


    private int setDeleteEngagement( HttpServletRequest request, HttpServletResponse response, mod.ValueObject.Thug realG )throws ServletException, IOException {
        int complete = -1;
        Integer ID = null;
        String DeleteState = "Delete";
        String DeleteUpdateComplete = "";
        
        System.out.println("\t<setDeleteEngagement>\n");
        ID = new java.lang.Integer((String)request.getParameter("_eID"));
        DeleteUpdateComplete = (String)request.getParameter("_DeleteUpdateComplete");  
   
        if(DeleteState.equals(DeleteUpdateComplete))
        complete = this.engagementAccessObject.deleteUserObligation( realG, ID ); 

        System.out.println("\t<DeleteUpdateComplete: "+DeleteUpdateComplete+", "+complete+">\n");     
        return complete;
    }
    

    private String getAccountFromRequest( String acctQtyPairString ){
        int t = 0;
        int tokenCount = 0;
        String delims = ",";   
        final int acctID = 1;      
        String qTargetAcct = "";
        String[] sourceTokens = null;   
        System.out.println("\t<getAccountFromRequest: "+acctQtyPairString+">\n");
        if(acctQtyPairString == null || acctQtyPairString.equals("")) return qTargetAcct;
       
        sourceTokens = acctQtyPairString.split(delims);
		tokenCount = sourceTokens.length;
		for (t = 0; t < tokenCount; t++) 
        {
			System.out.println("Split Account: "+ sourceTokens[t]);
		}
        qTargetAcct = sourceTokens[acctID];

        if(qTargetAcct!=null)
        {
            System.out.println("Return Account: " + qTargetAcct );
            return qTargetAcct;
        }
        else
        {
            return "";
        }        

    }

};
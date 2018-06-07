package mod.Control;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import mod.Utility.*;
import javax.servlet.*;
import mod.ValueObject.*;
import javax.servlet.http.*;


// A German word for now.
// February 3rd, 2107;
public class Momentan extends HttpServlet 
{
    private static final 
    long serialVersionUID = 1L;    

    private static String VERSION = ""; 
    private static String APP_ROOT = "";    
    private static String USER_MENU = "";
    private static String CASH_MENU = "";
    private static String ADMIN_STATUS = "";
    private static String GEIST_REQUEST_DISPATCH = "";
    private Benutzerkontozugriff benutzerkontozugriff;
    mod.ValueObject.ApproximatedCashBalance NullCashBalance = null;
    private mod.ValueObject.Thug HospitalityThug = new mod.ValueObject.Thug( "guest" );
    	

    public void init( ServletConfig config ) throws ServletException {
	  super.init(config);
      long t = System.currentTimeMillis();
      String Time = new java.util.Date(t).toString();
      System.out.println( "\t<Momentan is instantiated: "+Time+">" );
	  InputStream inputStream = this.getServletContext().getResourceAsStream("/WEB-INF/properties/rojo.properties");
	
		if(inputStream != null)
		{
            this.benutzerkontozugriff = new Benutzerkontozugriff(inputStream);
		}		
        else
        {
            System.out.println( "\t<Momentan is not instantiated>" );
        }		

      VERSION = config.getInitParameter("VERSION");
      APP_ROOT = config.getInitParameter("APP_ROOT");	  
	  USER_MENU = config.getInitParameter("USER_MENU");
      CASH_MENU = config.getInitParameter("CASH_MENU");
      ADMIN_STATUS = config.getInitParameter("ADMIN_STATUS");
	  GEIST_REQUEST_DISPATCH = config.getInitParameter("GEIST_REQUEST_DISPATCH");
      return ;
	}


    private mod.ValueObject.Thug geistFromSession( HttpSession ses ){
       mod.ValueObject.Thug tT = null;

       System.out.println( "\t<Momentan geistFromSession:"+
       ses.getAttribute("THUG")+">" );

       tT = (mod.ValueObject.Thug) ses.getAttribute("THUG");
       if( tT.equals( HospitalityThug )) return HospitalityThug ;
       return tT;
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
        String dispatchUpdateAcctBalance = null;
        String dispatchCashAcctManagement = null;
        System.out.println("\n\t<Momentan.doPost>\n");
        mod.ValueObject.ApproximatedCashBalance acb = null;       
        dispatchUpdateAcctBalance = (String)request.getParameter("updateAcctBalance");
        dispatchCashAcctManagement = (String)request.getParameter("cashAcctManagement");

        if((dispatchUpdateAcctBalance != null) 
            && dispatchUpdateAcctBalance.equals("updateAcctBalance"))
        {
            System.out.println( "\t<Momentan doPost, updateAcctBalance>" );
            acb = updateAccountBalance( request );
        }

        if((dispatchCashAcctManagement != null) && dispatchCashAcctManagement.equals("cashAcctManagement"))
        {
            System.out.println( "\t<Momentan doPost, cashAcctManagement>" );
            acb = cashAccountManagement( request );
        }

        response.sendRedirect(CASH_MENU);            
    	return ;
    }


    private synchronized mod.ValueObject.ApproximatedCashBalance cashAccountManagement( HttpServletRequest request ){
        String user = null;
        long t = System.currentTimeMillis();        
        mod.ValueObject.Thug myThug = null;
        java.lang.String SourceAccount = null;
        java.lang.String TargetAccount = null;
        java.lang.String BalanceUpdate = null; 
        String Time = new java.util.Date(t).toString();   
        myThug = geistFromSession(request.getSession());     
        mod.ValueObject.ApproximatedCashBalance mgtCashBalance = null;
        mod.ValueObject.UpdateBalanceMessage updateBalanceMessage = null;
        System.out.println( "\t<mod.Control.Momentan.cashAccountManagement: "+Time+">" );    

        if(myThug.equals( HospitalityThug )) {
            System.out.println("\t\"HospitalityThug\"");
            return NullCashBalance;
        } 

        System.out.println( "\t-- - --" );
        user = (String) myThug.getCodename();    

        java.lang.Float update = new Float( 
            (String) request.getParameter("updateAmount") 
            );

        // Subtract BalanceUpdate FROM SourceAccount: ApproximatedCashBalance
        SourceAccount = (String) request.getParameter("fromSourceAcct") ;
        //java.lang.NumberFormatException: For input string: "165.0,2719"
        SourceAccount = getAccountFromRequest( SourceAccount );

        System.out.println( "\tSourceAcct: "+SourceAccount);  
        System.out.println( "\tBalance: "+ benutzerkontozugriff.getUserBalance( user, new Integer (SourceAccount) ) );
        System.out.println( "\t--" );

        // Add BalanceUpdate TO TargetAccount: ApproximatedCashBalance  
        TargetAccount = (String) request.getParameter("toDestinationAcct") ;
        //java.lang.NumberFormatException: For input string: "65.5,7063"
        TargetAccount = getAccountFromRequest( TargetAccount );

        System.out.println( "\tDestinationAcct: "+TargetAccount);  
        System.out.println( "\tBalance: "+ benutzerkontozugriff.getUserBalance( user, new Integer (TargetAccount) ) );
        System.out.println( "\t- - -\n" );
 
        System.out.println( "\tSourceAcct: "+SourceAccount);  
        System.out.println( "\tBalance updated: "+ benutzerkontozugriff. createAccountWithdrawal( SourceAccount, user, update ) );
        System.out.println( "\tDestinationAcct: "+TargetAccount);  
          mgtCashBalance = benutzerkontozugriff. createAccountDeposit( TargetAccount, user, update );
        System.out.println( "\tBalance updated: "+  mgtCashBalance);
        System.out.println( "\t- --- -\n" );

        return mgtCashBalance;    
    }


    private mod.ValueObject.ApproximatedCashBalance updateAccountBalance( HttpServletRequest request ){
        java.lang.String transTtype = "";
        java.lang.String whoIsThis = null;
        long t = System.currentTimeMillis();
        mod.ValueObject.Thug myThug = null;        
        java.lang.String TargetAccount = null;
        java.lang.String BalanceUpdate = null;           
        String Time = new java.util.Date(t).toString();
        mod.ValueObject.ApproximatedCashBalance uCashBalance = null;

        /**
        Event = InformationOntology( Category  )
        Statistic = UniqueInformationEvent( time, Observation  )
        Pattern = AggregateInformationArray( time, Observation[time] )
        */

        System.out.println( "\t<mod.Control.Momentan.updateAccountBalance: "+Time+">" );

        // Web boundary: User;
        myThug = geistFromSession(request.getSession());

        if(myThug.equals( HospitalityThug )) 
        {
            System.out.println("\tFound, \"HospitalityThug\", but did not find a requester identity");
            return uCashBalance;
        }

        whoIsThis = (String) myThug.getCodename();
        if(whoIsThis==null) 
        {
            System.out.println( "\t[updateAccountBalance] whoIsThis is null." );
            return uCashBalance;
        }

        // Web boundary: Account;
        //TargetAccount = (String) request.getQueryString() ;
        TargetAccount = (String) request.getParameter("fromSourceAcct") ;
        System.out.println("\t[Account] " + TargetAccount );  
        if(TargetAccount==null) 
        {
            System.out.println( "\t[updateAccountBalance] TargetAccount is null." );
            return uCashBalance;
        }

        uCashBalance = benutzerkontozugriff.getUserBalance( whoIsThis.trim(), new Integer(TargetAccount) );

        System.out.println( "\t[updateAccountBalance] TargetAccount:" + TargetAccount );

        System.out.println( "\t[updateAccountBalance] Balance:" + uCashBalance.getBalanceInDollars() );

        // Web boundary: Amount;
        BalanceUpdate = (String) request.getParameter("updateAmountInput") ;
        System.out.println("\t[BalanceUpdate] " + BalanceUpdate );
        if(BalanceUpdate==null) 
        {
            System.out.println( "\t[updateAccountBalance] BalanceUpdate is null." );
            return uCashBalance;
        }

        // Web boundary: Operation, subtraction;
        transTtype = (String) request.getParameter("withdrawalRadio");        
        if(transTtype != null && transTtype.equals("withdrawal"))
        {
            mod.ValueObject.ApproximatedCashBalance withdrawalApproximateCashBalance = null;
            System.out.println("\t[Withdrawal] " + transTtype ); 

            withdrawalApproximateCashBalance = benutzerkontozugriff.createAccountWithdrawal( 
                    TargetAccount, whoIsThis, new Float(BalanceUpdate) );

            UpdateBalanceMessage updateBalanceMessage = new UpdateBalanceMessage( uCashBalance,  
                withdrawalApproximateCashBalance, TargetAccount, whoIsThis
                );
                
                  UpdateBalanceMessage.recordUpdateBalance( updateBalanceMessage ) ;

            return withdrawalApproximateCashBalance;
        }

        // Web boundary: Operation, addition;
        transTtype = (String) request.getParameter("depositRadio");
        if(transTtype != null && transTtype.equals("deposit"))
        {
            mod.ValueObject.ApproximatedCashBalance depositApproximateCashBalance = null;
            System.out.println("\t[Deposit] " + transTtype ); 

            depositApproximateCashBalance = benutzerkontozugriff.createAccountDeposit( 
                    TargetAccount, whoIsThis, new Float(BalanceUpdate) );

            UpdateBalanceMessage updateBalanceMessage = new UpdateBalanceMessage( uCashBalance,  
                depositApproximateCashBalance, TargetAccount, whoIsThis
                );

                UpdateBalanceMessage.recordUpdateBalance( updateBalanceMessage ) ;

            return depositApproximateCashBalance;
        }

        if(transTtype==null) 
        {
            System.out.println( "\t[updateAccountBalance] depositRadio is null." );
            return uCashBalance;
        }

        return uCashBalance;
    }


    private mod.ValueObject.ApproximatedCashBalance createAccountDeposit( HttpServletRequest request ){
        java.lang.String whoIsThis = null;
        mod.ValueObject.Thug myThug = null;
        java.lang.String TargetAccount = null;
        java.lang.String BalanceAmount = null;
        mod.ValueObject.ApproximatedCashBalance dCashBalance = null;
        System.out.println( "\t<mod.Control.Momentan.createAccountDeposit>" );

        // Web boundary;
        myThug = (mod.ValueObject.Thug) 
            request.getSession().getAttribute("Identitat");

        if(myThug==null) 
        {
            System.out.println("\tCould not find requester identity");
            return dCashBalance;
        }

        whoIsThis = (String) myThug.getCodename();

        BalanceAmount = (String) request.getParameter("updateAmount") ;
        System.out.println("\t[BalanceAmount] " + BalanceAmount );
        
        TargetAccount = (String) request.getParameter("toDestinationAcct") ;
        System.out.println("\t[DestinationAccount] " + TargetAccount );   

        if(ADMIN_STATUS.equals("true"))
        System.out.println("\n\t<Momentan: "+whoIsThis+" createAccountDeposit on "+TargetAccount+">");

        // DB boundary;
        if(benutzerkontozugriff==null)
        {
            System.out.println("<DB access is null.>");
            return dCashBalance;
        }

        dCashBalance = benutzerkontozugriff.createAccountDeposit(TargetAccount, whoIsThis, new Float(BalanceAmount));

        System.out.println( "\t<mod.Control.Momentan.createAccountDeposit returns "+dCashBalance+">" );
        
        return dCashBalance; 
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
	

    private String getSourceAcctFromRequest( final String acctQtyPairString ){
        int s = 0;        
        int tokenCount = 0;
        final int acctID = 1;
        String delims = ","; 
        String qSourceAcct = "";
        String[] sourceTokens = null;   
        if(acctQtyPairString == null || acctQtyPairString.equals("")) return qSourceAcct;

        sourceTokens = acctQtyPairString.split(delims);
		tokenCount = sourceTokens.length;
		for (s = 0; s < tokenCount; s++) 
        {
			System.out.println("Split SourceAccount: "+ sourceTokens[s]);
		}
        qSourceAcct = sourceTokens[acctID];

        if(qSourceAcct!=null)
        {
            System.out.println("Return SourceAccount: " + qSourceAcct );
            return qSourceAcct;
        }
        else
        {
            return "";
        }

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


class Konversation{
    
    public Konversation( ){
        System.out.println("\t<Konversation>");
    }
    
    public static boolean hasValidSession( HttpServletRequest request ){
        boolean hasValidSession = true;
        // Will return 'null' if 
        // no session -- or if 
        // session is invalid;
        HttpSession session = request.getSession(false);  

        if(session==null) 
        return false;

        if(session != null) {
            // You have a current 
            // OR existing 
            // OR old Session;
            session.invalidate();  // invalidate session - this will remove any old attrs hold in the session

        }
        
        return hasValidSession;
    }

}
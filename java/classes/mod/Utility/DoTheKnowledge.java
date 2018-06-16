package mod.Utility;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;

public class DoTheKnowledge  {

    /* October 25th, Weds - 2017;
    Null, Never, Nobody, Negative, Zero and False
    * A candidate for the Singleton Pattern - for
    * we maintain a count of connections;
    */    
 
    private static InputStream inputStream;
    private static Properties facilityProps;
    private static int ConnectionCount = 0;

    public DoTheKnowledge(){
        System.out.println("\t<DoTheKnowledge>");
        return;
    }

    public DoTheKnowledge(InputStream configStream){
             try{          

                inputStream = configStream;

                facilityProps = new Properties();

			    if( inputStream == null )
			    {
	  			    System.out.println("\t<DoTheKnowledge could not instantiate the inputStream.>\n");
			    }
			
			    if( inputStream != null )
		    	{
	  		    	System.out.println("\n\t<DoTheKnowledge found " +inputStream.available()+ " config bytes available.\n");
			    }
			
                facilityProps.load(inputStream);

                System.out.println( "\tConfig Streaming: " + facilityProps + "\n");
            } 
            catch (Exception e) 
            {
                System.out.println( "\nDoTheKnowledge, construction Exception;" );
                e.printStackTrace();
            }  
        return ;      
    }


    public static String getJdbcProperty( String jdbcProp )
    {
        String theProperty = "...";

        if(jdbcProp==null||jdbcProp.equals(""))
            jdbcProp = theProperty;

        System.out.println( "\t<getJdbcProperty: "+jdbcProp+">" );

        if(facilityProps==null) return theProperty;
        {
            System.out.println( "\t<The JdbcProperties file is empty.>" );
        }

        System.out.println( "\t<Prop:"+jdbcProp+">" );
        theProperty = (String) facilityProps.getProperty(jdbcProp);
        System.out.println( "\t<Val:"+theProperty+">" );
        
        if(theProperty==null || theProperty.equals("")) 
            theProperty = "";
        
        return theProperty;
    }


    public static void assignProperties( InputStream activeProp ){
             try{          

                if(inputStream == null) inputStream = activeProp;

                if(facilityProps == null) facilityProps = new Properties();

			    if( inputStream == null )
			    {
	  			    System.out.println("\t<DoTheKnowledge.assignProperties could not assign the inputStream.>\n");
			    }
			
			    if( inputStream != null )
		    	{
	  		    	System.out.println("\n\t<DoTheKnowledge assined " +inputStream.available()+ " config bytes.\n");
			    }
			
                if(facilityProps.isEmpty()) facilityProps.load(inputStream);

                System.out.println("\nProperties Assigned:" + facilityProps );
                
            } 
            catch (Exception e) 
            {
                System.out.println( "\nDoTheKnowledge, assignProperties Exception;" );
                e.printStackTrace();
            }  
        return ;  
    }


    public static int getConnectionCount(){
    System.out.println("\n\t<DoTheKnowledge JNDI Connection Accounting "+ConnectionCount+" connections>");
    return  ConnectionCount ;
    }


    public static void closeConnection(Connection cConnection)
    {
        resolveDatabaseResource(cConnection);
        return ; 
    }


    public static Connection getConnected( ){
            System.out.println( "\n\t<DoTheKnowledge.getConnected>");
        
            Connection conn = null;            
            try 
            {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:comp/env");
                DataSource ds = (DataSource) envContext.lookup(getJdbcProperty("DataSourceLookup"));
                conn = ds.getConnection();
            } 
            catch (NamingException ex) 
            {
                System.err.println(ex);
            } 
            catch (SQLException ex) 
            {
                System.err.println(ex);
            }

        if(conn!=null) ConnectionCount++;
        
        return conn;
    }


    /**
     * Not a behavior that we want to exercize.
     */
    public static void resolveDatabaseResource( ResultSet rSet )
    {
        System.out.println( "\n\t<resolveDatabaseResource:" +"\n\t" + rSet.toString() +">" );

        try {
        //after you finish
        if(rSet instanceof ResultSet)
        System.out.println( "\n\t<Try to close and null out, " + 
            rSet.getClass().getName() +">" );

        rSet.close(); //if a ResultSet was returned
        rSet = null ;
        }
        catch(SQLException se){
	    se.printStackTrace();
        }     

        return ;
    }


    /**
     *
     */
    public static void resolveDatabaseResource( Statement state )
    {
        System.out.println( "\n\t<resolveDatabaseResource, " + state.toString() +">" );
        
        try {
        //after you finish
        if(state instanceof Statement)
        System.out.println( "\n\t<Try to close and null out, " + 
            state.getClass().getName() +">" );

        state.close(); //if a Statement was returned
        state = null ;
        }
        catch(SQLException se){
	    se.printStackTrace();
        }            
        return ;
    }


    /**
     *
     */
    public static void resolveDatabaseResource( Connection connected )
    {
        System.out.println( "\n\t<resolveDatabaseResource, " + connected.toString() +">" );
        
        try {
        //after you finish
        if(connected instanceof Connection)
        System.out.println( "\n\t<Try to close and null out, " + 
            connected.getClass().getName() +">" );

        connected.close(); //if a Statement was returned
        connected = null ;
        }
        catch(SQLException se){
	    se.printStackTrace();
        }     

        return ;
    } 

    
public static boolean resolveOpenDatabaseResources( Connection connected, Statement stated, ResultSet results ){
    boolean allDone = true;
    return allDone;
}


     
public static void main( String[] j )
{
  return;
}

};
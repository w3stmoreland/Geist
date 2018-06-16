package mod.Utility;

import java.io.*;
import java.sql.*;
import java.util.*;
import mod.ValueObject.*;

// A German word for 
// Account Data Access;
// January 4th, 2017;
public class Benutzerkontozugriff
{

    private Connection connection = null;
    private DoTheKnowledge dmInstance = null;   

    public Benutzerkontozugriff(InputStream inStream) 
    {        
        mod.Utility.DoTheKnowledge.setTheKnowledge(inStream);
        connection =  mod.Utility.DoTheKnowledge.getConnected( );
        int connCount = mod.Utility.DoTheKnowledge.getConnectionCount();
        System.out.println( "\t<Benutzerkontozugriff has ["+connCount+"] active connections: " + connection +">" );        
        return ;
    }
    
    
    public Connection getJdbcConnection( )
    {
        try 
        {
            if( this.connection == null || this.connection.isClosed() ) 
                this.connection =  mod.Utility.DoTheKnowledge.getConnected( ); 
    	} 
        catch (SQLException e) 
        {
        	System.out.println(e.getMessage());        
        }
        
        return this.connection;
    }


    public mod.ValueObject.ApproximatedCashBalance createAccountDeposit( final String acctDestination, final String user, final Float deposit ) {

        String acctOwner = user;

        Integer acctIdentity = null;

        Float fDepositAmount = null;
        
        PreparedStatement preparedStatement = null;

        if(deposit!=null && deposit instanceof Float) 
            fDepositAmount = deposit;

        if(acctDestination!=null && acctDestination instanceof String) 
            acctIdentity = new Integer(acctDestination);
        

        if(acctDestination == null || acctDestination.equals("")) acctIdentity = new Integer("0");   

        System.out.println( "\t<Benutzerkontozugriff: createAccountDeposit into " + acctIdentity + ">");

        mod.ValueObject.ApproximatedCashBalance aCashBalance = new mod.ValueObject.ApproximatedCashBalance("0","0","0");    

        String  updateBalAcct = "UPDATE Balances, Accounts SET Balances.deposit_in_usd = deposit_in_usd + ? WHERE Accounts.acct_owner=? AND Balances.acct_id=?;";
        
        //
        //
        if( acctDestination==null || user==null || deposit==null) 
        { 
           System.out.println( "\t[createAccountDeposit, user" + user + ", deposit, "+deposit+"]"); 
           return aCashBalance; 
        }

		try 
        {
            connection = getJdbcConnection( );            
            preparedStatement = connection.prepareStatement(updateBalAcct);            
			preparedStatement.setFloat(1,fDepositAmount);
			preparedStatement.setString(2,user);
            preparedStatement.setInt(3,acctIdentity);
			preparedStatement.executeUpdate();

    	} 
        catch (SQLException e) 
        {
        	System.out.println(e.getMessage());        
        }

        aCashBalance = getUserBalance(user, acctIdentity) ;

        System.out.println( "\t<Benutzerkontozugriff: AccountDeposit "+ aCashBalance.toString() +">");
        //
        mod.ValueObject.ApproximatedCashBalance.recordApproximateCashBalance(aCashBalance);

        return aCashBalance;
    }
    

    public mod.ValueObject.ApproximatedCashBalance createAccountWithdrawal( final String acct, final String user, final Float withdrawal ) {
        // EXPECTATION|Goal: 
        //  return aCashBalance with a value for balanceInDollars less withdrawal;

        // EXPECTATION|Prediction: 
        //  aCashBalance = aCashBalance -  withdrawal;

        // EXPECTATION|expected Exception: 
        String acctOwner = user;
        Integer acctIdentity = null;
        Float fDepositAmount = withdrawal;
        mod.ValueObject.ApproximatedCashBalance aCashBalance = null;

        if(acct==null||acct.equals("")) 
        {
            mod.ValueObject.ApproximatedCashBalance noSourceCash = new mod.ValueObject.ApproximatedCashBalance("0", "0", "0");
            System.out.println( "\t<Benutzerkontozugriff: createAccountWithdrawal without source account, "+noSourceCash.toString()+">");
            return noSourceCash; 
        }

        acctIdentity = new Integer(acct);
        PreparedStatement preparedStatement = null;
        System.out.println( "\t<Benutzerkontozugriff: createAccountWithdrawal " + acct +", " +withdrawal+">" );
        String  updateBalAcct = "UPDATE Balances, Accounts SET Balances.deposit_in_usd = deposit_in_usd - ? WHERE Accounts.acct_owner=? AND Balances.acct_id=?;";
        System.out.println( "\t[createAccountWithdrawal SQL: " + updateBalAcct );

        if( acct==null || 
             user==null || 
             withdrawal==null) { return aCashBalance; }

		try 
        {
            connection = getJdbcConnection( ); 
            preparedStatement = connection.prepareStatement(updateBalAcct);
			preparedStatement.setFloat(1, fDepositAmount);
			preparedStatement.setString(2, user);
            preparedStatement.setInt(3, acctIdentity);
			preparedStatement.executeUpdate();

    	} 
        catch (SQLException e) 
        {
        	System.out.println(e.getMessage());        
        }

        aCashBalance = getUserBalance(user, acctIdentity) ;

        System.out.println( "\t<Benutzerkontozugriff: AccountWithdrawal " + aCashBalance.toString() +">" );

        mod.ValueObject.ApproximatedCashBalance.recordApproximateCashBalance(aCashBalance);

        return aCashBalance;
    }
 
 
    public mod.ValueObject.ApproximatedCashBalance getUserBalance(final String user, final Integer acct_id) {
	    // EXPECTATION|Goal: 
        //  write SQL command to existing (db) connection;

        // EXPECTATION|Goal: 
        //  return balance for user and acct_id;

        // EXPECTATION|Prediction: 
        //  tCashBalance AND sCashBalance have updated state;
        // EXPECTATION|expected Exception: 
        
        ResultSet rs = null;

        PreparedStatement statement = null;

        mod.ValueObject.ApproximatedCashBalance balance = null ;

        System.out.println("\t<Benutzerkontozugriff: getUserBalance " + acct_id +">\n");

        String  getTheSelection = "SELECT a.acct_ID, b.deposit_in_usd, b.balance_date_time from accounts a, balances b WHERE a.acct_ID =? AND a.acct_owner=?;" ;

        try 
        {
            connection = getJdbcConnection( ); 
            statement = connection.prepareStatement(getTheSelection);
            statement.setInt(1, acct_id);
            statement.setString(2, user);
            rs = statement.executeQuery();

           while (rs.next()) 
           {
                balance = new  mod.ValueObject.ApproximatedCashBalance(
                    rs.getInt("a.acct_ID"), 
                    rs.getDouble("b.deposit_in_usd"), 
                    rs.getDate("b.balance_date_time") 
                    );

                System.out.println("\t[ApproximatedCashBalance]: " + balance.getBalanceInDollars() );
            }
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }

        return balance;
    }
    

    public List<mod.ValueObject.ApproximatedCashBalance> getUserBalances(final String user) 
    {
	    mod.ValueObject.ApproximatedCashBalance balance = null ;
	    
        List<mod.ValueObject.ApproximatedCashBalance>  balances = new ArrayList<mod.ValueObject.ApproximatedCashBalance>();

        try 
        {
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery( "SELECT a.acct_ID, bank_name, acct_descr, acct_owner," +  
                    "b.deposit_in_usd, b.balance_date_time from accounts a, balances b WHERE " + 
                    "a.acct_ID = b.acct_ID AND acct_owner=\""+  user + "\" ");
        
           while (rs.next()) 
           {

                balance = new mod.ValueObject.ApproximatedCashBalance(rs.getInt("acct_ID"),
                        rs.getDouble("deposit_in_usd"), 
                        rs.getDate("balance_date_time")
                        );

                balances.add(balance);
            }
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }

        return balances;
    }


   public static void main( String[] j )
   {
    Benutzerkontozugriff grif = null; 

    if(j.length <1) 
    {
        System.out.println("\n\t<Not enough commandline information to execute Benutzerkontozugriff.>\n");
        return;
    }
    try{
        System.out.println("\n\t<Benutzerkontozugriff configured with: \"" +j[0] + "\">\n");
	    grif = new Benutzerkontozugriff(new FileInputStream(j[0]));
    }
    catch( Exception e ) 
    {
      e.printStackTrace();
    }

    grif.getUserBalance("Hwestmoreland", 7063); 

    return;
   }

} ;
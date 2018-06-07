package mod.ValueObject;

/*
mysql> SELECT * FROM Balances;

+-----------+----------------+---------------------+
| acct_ID   | deposit_in_usd | balance_date_time   |
+-----------+----------------+---------------------+
|      2007 |            0.5 | 2016-07-14 23:11:40 |
| 757710158 |             35 | 2013-07-30 17:45:27 |
|      3289 |           1.95 | 2015-02-19 11:26:26 |
|         0 |              0 | 2015-06-02 10:49:29 |
|   3812028 |         100.75 | 2016-09-23 10:22:18 |
|      7063 |         110.05 | 2016-08-20 23:09:42 |
|    926364 |              0 | 2015-04-01 12:22:45 |
|    926360 |         505.75 | 2015-01-22 13:39:18 |
|      2719 |           2005 | 2016-10-04 17:34:21 |
|      1992 |              0 | 2014-12-18 12:36:11 |
|      2822 |            5.5 | 2016-09-08 18:11:07 |
|      8411 |              0 | 2014-07-20 12:45:49 |
|      3516 |            225 | 2016-10-04 17:42:09 |
|      7828 |            440 | 2016-10-04 17:41:49 |
+-----------+----------------+---------------------+
14 rows in set (0.06 sec)
*/
	
import java.util.*;
import java.lang.*;
import java.io.*;

public class ApproximatedCashBalance<A, B, C> implements java.io.Serializable {

	private final A acctID;
	private final B balanceInDollars;
	private final C balanceDateTime;     

	/**
	 * Construct an ApproximatedCashBalance using the supplied object instances.
	 *
	 * @param acctID the bank id for the ApproximatedCashBalance, may NOT be null
	 * @param balanceInDollars the amoung/quantity id of the CashBalance, may NOT be null
	 * @param balanceDateTime the account balance time
	 */
	public ApproximatedCashBalance(A acct, B balance, C dateTime) 
	{
	  this.acctID = acct;
	  this.balanceInDollars = balance;
	  this.balanceDateTime = dateTime;  
	  System.out.println("\t<"+this.toString()+">");	  
	  return ;
	}

	// required for JAXB serialization/deserialization.
	private ApproximatedCashBalance() {
	  this.acctID = null;
	  this.balanceInDollars = null;
	  this.balanceDateTime = null;
	  return ;
	}
	
	/**
	 * Return the liabilityID object, may NOT be null.
	 *
	 * @return the liabilityID object in the ApproximatedCashBalance.
	 */
	public A getAcctID() {
		return  this.acctID;
	}


	/**
	 * Return the debtID object, may NOT be null.
	 *
	 * @return the debtIDobject in the ApproximatedCashBalance.
	 */
	public B getBalanceInDollars() {
		return  this.balanceInDollars;
	}

	
	/**
	 * Return the debtBalance object, may NOT be null.
	 *
	 * @return the debtBalance object in the ApproximatedCashBalance.
	 */
	public C getBalanceDateTime() {
		return this.balanceDateTime;
	}


   public static String recordApproximateCashBalance(ApproximatedCashBalance aBalance){
    	String fileId = "";
		java.lang.Object tagId = 
			aBalance.getAcctID(); 
    	java.util.Properties cashProps = null;
    	long sctm = System.currentTimeMillis();    	  
    	Long bEasyCashTime = new java.lang.Long(sctm); 	
    	System.out.println("\t" + aBalance.toString());
		System.out.println( "\t<ApproximatedCashBalance: recordApproximateCashBalance>" );
    	
    	if( cashProps == null )
    	{
    		cashProps = new java.util.Properties();    
    	}
    	  
    	cashProps.setProperty(aBalance.getAcctID().toString(), aBalance.toString());

    	fileId = tagId.toString() + "-Cash-" + bEasyCashTime + ".xml";
    	
        try
        {
        	cashProps.storeToXML(new java.io.FileOutputStream(fileId), 
        		tagId.toString(), "UTF-8" 
        		);
        	
        }catch( Exception e )
        {
        	e.printStackTrace();
        }
        
    	return tagId.toString();
    }
    
    
    @Override
	public String toString() {
		final StringBuilder sb = new StringBuilder();
		sb.append("ApproximatedCashBalance");
		sb.append("{").append(acctID);
		sb.append(", ").append(balanceInDollars);
		sb.append(", ").append(balanceDateTime);
		sb.append('}');
		return sb.toString();
	}


	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof ApproximatedCashBalance)) return false;
		ApproximatedCashBalance ApproximatedCashBalance = (ApproximatedCashBalance) o;
		if (acctID != null ? !acctID.equals(ApproximatedCashBalance.acctID) : ApproximatedCashBalance.acctID != null) return false;
		if (balanceInDollars != null ? !balanceInDollars.equals(ApproximatedCashBalance.balanceInDollars) : ApproximatedCashBalance.balanceInDollars != null) return false;
		if (balanceDateTime != null ? !balanceDateTime.equals(ApproximatedCashBalance.balanceDateTime) : ApproximatedCashBalance.balanceDateTime != null) return false;
		return true;
	}


	@Override
	public int hashCode() {
		int result;
		result = (balanceInDollars != null ? balanceInDollars.hashCode() : 0);
		result = 31 * result + (balanceInDollars != null ? balanceInDollars.hashCode() : 0);
		return result;
	}

}
// The "ApproximatedCashBalance" class;
;
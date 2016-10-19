public with sharing class AccountExist {

   set<String> nameSet = new set<String>();
   set<String> emailSet = new set<String>();
   Public Account account{get; set;}
   
  public AccountExist(ApexPages.StandardController stdController) {
  	account = new Account();
  }
  
    /*Public void SearchDuplicateAccount(List<Account> lstNewAcc)
   {
   	for(Account acc : lstNewAcc)
   	{
   		nameSet.add(acc.name);
   		emailSet.add(acc.Email__C);
   	}
   	        
   	 Map<Id,Account> mapacc = new Map<Id,Account>([Select Id,
   	                                  name,
   	                                  Email__c
                                      from Account
                                 WHERE name IN :nameSet
                                And Email__C IN :emailSet]);
     
     for(Account acc : lstNewAcc)
     {
     	for(Account existingAcc: mapacc.values())
     	{
     		if(acc.name.equals(existingAcc.name) && acc.Email__c ==  existingAcc.Email__c)
     		
     		{
     			acc.addError('Account Already Exist');
     			break;
     		}
     		
     	}
     }
     
   }*/
   Public void saveAccount()
   {
   	  list<Account> lstAccount = [Select Id,
                                      name,
                                      Email__c
                                      from Account
                                 WHERE name = :account.Name
                                And Email__C = :account.Email__c];
       if(lstAccount!=null)
       {
       	  account.addError('Account Already Exist');
               
       }
       else 
       insert account; 
   }
   
}
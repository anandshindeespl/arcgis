public with sharing class accwithopp {
public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
    List<Opportunity> OpportunityUpload;
    	ID idacc=Null;
        ID idprice=Null;
    
    public Pagereference ReadFile()
    {
        nameFile=contentFile.toString();
        filelines = nameFile.split('\n');
        OpportunityUpload = new List<Opportunity>();
         list<String> inputfields1=filelines[0].split('\t');
        // integer si=inputfields1.size();
         
         system.debug('inputfields1'+inputfields1);
         
             system.debug('inputfields1'+inputfields1.size());
         
           
       
           
        for (Integer i=1;i<filelines.size();i++)
        {
            list<String> inputvalues=new list<string>();
            //system.debug('size is....'+ filelines[i].size());
            
            inputvalues = filelines[i].split('\t');
              integer si=inputvalues.size();
           system.debug('inputvaluess....'+ inputvalues);
           
            system.debug('inputvaluess....'+ si);
          
           
            Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Opportunity.fields.getMap();
           List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
           
          // String AccountName=inputvalues[0];
         	Opportunity a = new Opportunity();
         
          // list<Account> Id =[Select Id,Name from Account where Name=: AccountName];
            for( Integer j=0;j<si;j++)
                 {
                   for(Schema.SObjectField s : fldObjMapValues)
                   {
                  String theName = s.getDescribe().getName();
                  system.debug('theName----'+theName);
                  String theLabel= s.getDescribe().getLabel();
                  //String type1=s.getDescribe().getType();
                  system.debug('theLabel----'+theLabel);
                     Schema.DisplayType fielddataType = fldObjMap.get(string.valueOf(s)).getDescribe().getType();
                     system.debug('datatype for....'+fielddataType);
                 // Boolean result = theName.equalsIgnoreCase(inputfields1[j]);
                
           if(theName.equalsIgnoreCase(inputfields1[j].trim()))
           {
           	system.debug('value of csv'+inputfields1[j]);
           	system.debug('SSSSSSS');
           	
              if(theName.equalsIgnoreCase('AccountId'))
              {
              	String AccountName=inputvalues[j];
              	 list<Account> Id =[Select Id,Name from Account where Name=: AccountName];

              system.debug('ids.......'+Id);
           
           
                   if(Id.isEmpty())
                    {
                    	 idacc=Accid(AccountName);
                    	   a.put(theName,idacc);
                    	  system.debug('new created....'+idacc);
                    	  break;
                    }
                    else
                    {
           		      
           			
            	           for(Account acc:Id)
           		            { 	
            			a.put(theName,acc.Id);
            			system.debug('existing account..'+acc.Id);
            			
           		            } 
            			system.debug('Opportunity Account ID'+a.AccountId );
            			break;                    
                    }	
            	     
           
                  
           
        }
        
         if(theName.equalsIgnoreCase('Pricebook2Id'))
              {
              	String pricebookName=inputvalues[j];
              	 list<pricebook2> Id =[Select Id,Name from pricebook2 where Name=: pricebookName];

              system.debug('ids.......'+Id);
           
           
                   if(Id.isEmpty())
                    {
                    	 idprice=priceid(pricebookName);
                    	   a.put(theName,idprice);
                    	  system.debug('new created....'+idprice);
                    	  break;
                    }
                    else
                    {
           		      
           			
            	           for(pricebook2 pri:Id)
           		            { 	
            			a.put(theName,pri.Id);
            			system.debug('existing account..'+pri.Id);
            			
           		            } 
            			system.debug('Opportunity Account ID'+a.pricebook2Id );
            			break;                    
                    }	
            	     
           
                  
           
        }
        else if(string.valueOf(fielddataType).equalsIgnoreCase('Currency') || string.valueOf(fielddataType).equalsIgnoreCase('Percent'))
                   	{
                   		System.debug('********************************'+theName);
                   	Double d = Double.valueOf(inputvalues[j]);
                   	system.debug('d--------'+d);
                   	 a.put(theName,d);
                   	 break;
                   	}
                   	
   
          else if(string.valueOf(fielddataType).equalsIgnoreCase('Date'))
                   	{
                   		
                   		System.debug('********************************');
                   Date  tempDate;
			            String dt=string.valueOf(inputvalues[j]);
						String[] tempStr = dt.split('-');
						Integer y = Integer.valueOf(tempStr[0]);
						Integer m = Integer.valueOf(tempStr[1]);
						Integer d = Integer.valueOf(tempStr[2]);
						tempDate =  Date.newInstance(y,m,d);
						
						  // System.debug('tempDate======='+tempDate);
			//thisObj.put(headerName,tempDate);
			           
			            
                   	 a.put(theName,tempDate);
                   	 break;
                   	}
        else
        {
            a.put(theName,inputvalues[j]);	
            break;
        }
           }
                   }
                 }
                  OpportunityUpload.add(a);
        }
        
        try{
        insert OpportunityUpload;
        }
        catch (Exception e)
        {
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured. Please check the template or try again later');
            ApexPages.addMessage(errormsg);
        }    
        
    
    return null;
    }
    
    public Id Accid(String s)
    {
    	 System.debug('Inside Accid Method*******');
    	
    	Account ac=new Account();
    	ac.Name=s;
    	insert ac;
 
    	System.debug('New Account Id*******'+ac.Id);
    	return ac.id;
    }
    
     public Id priceid(String s)
    {
    	 System.debug('Inside Accid Method*******');
    	
    	pricebook2 pb=new pricebook2();
    	pb.Name=s;
    	insert pb;
 
    	System.debug('New Account Id*******'+pb.Id);
    	return pb.id;
    }
    
    
    public List<Opportunity> getuploadedOpportunitys()
    {
        if (OpportunityUpload!= NULL)
            if (OpportunityUpload.size() > 0)
                return OpportunityUpload;
            else
                return null;                    
        else
            return null;
    }            

}
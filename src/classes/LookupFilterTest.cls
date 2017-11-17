/** Test Class to test the functionality of LookupFilter
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      2.0b
*/
@isTest 
global class LookupFilterTest{
    public static final String NOT_EQUAL = 'notEqual';
    public static final String EQUALS = 'equals';
    public static final String NOT_CONTAIN = 'notContain';
    public static final String CONTAINS = 'contains';
    public static final String STARTS_WITH = 'startsWith';
    public static final Integer LEAD_SIZE = 10;
    public static final Integer LEAD_SIZE_ALL = 20;

    /* 
    * Method to add the records for testing
    */
    @testsetup
    static void setup() {
        
        Lead[] leadList = new List<Lead>();
        for(Integer i = 0 ; i < 20 ; i++) {
            leadList.add(new Lead(FirstName = 'Test ' + i, LastName = 'lead' + i,Company = 'test Company ' + i, Status = 'Open - Not Contacted', City='Bhopal'));
        }
        for(integer i = 10 ; i < 20 ; i++) {
            leadList.add(new Lead(FirstName = 'Test ' + i, LastName = 'lead' + i,Company = 'test Company ' + i, Status = 'Open - Not Contacted', City='Mumbai'));
        }
        insert leadList;
    }

    /* 
    * Method to test the functionality of getting the object values from org with all valid data
    * And filter with not equal to criteria
    */  
    @isTest
    static void findByNameWithLookupValue_And_NotEqual_Lookupfilter_Test() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock(NOT_EQUAL));
        String filter = LookupFilter.getLookupFilter('Account', 'leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a', 'Lead', 'leadLookup__c', filter);
        Test.stopTest();
        System.assertEquals(LEAD_SIZE_ALL, recordList.size(),'The number of records fetched is unexpected');
    }
    
    /* 
    * Method to test the functionality of getting the object values from org with all valid data
    * And filter with equal to criteria
    */  
    @isTest
    static void findByNameWithLookupValue_And_Equals_Lookupfilter_Test() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock(EQUALS));
        String filter = LookupFilter.getLookupFilter('Account', 'leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a', 'Lead', 'leadLookup__c', filter);
        Test.stopTest();
        System.assertEquals(LEAD_SIZE, recordList.size(),'The number of records fetched is unexpected');
    }

     /* 
    * Method to test the functionality of getting the object values from org with all valid data
    * And filter with not contains criteria
    */  
    @isTest
    static void findByNameWithLookupValue_And_NotContain_Lookupfilter_Test() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock(NOT_CONTAIN));
        String filter = LookupFilter.getLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a', 'Lead', 'leadLookup__c', filter);
        Test.stopTest();
        System.assertEquals(LEAD_SIZE, recordList.size(),'The number of records fetched is unexpected');
    }

     /* 
    * Method to test the functionality of getting the object values from org with all valid data
    * And filter with contains criteria
    */  
    @isTest
    static void findByNameWithLookupValue_And_Contains_Lookupfilter_Test() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock(CONTAINS));
        String filter = LookupFilter.getLookupFilter('Account', 'leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a', 'Lead', 'leadLookup__c', filter);
        Test.stopTest();
        System.assertEquals(LEAD_SIZE_ALL, recordList.size(),'The number of records fetched is unexpected');
    }

     /* 
    * Method to test the functionality of getting the object values from org with all valid data
    * And filter with Starts with criteria
    */  
    @isTest
    static void findByNameWithLookupValue_And_StartsWith_Lookupfilter_Test() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock(STARTS_WITH));
        String filter = LookupFilter.getLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a', 'Lead', 'leadLookup__c', filter);
        Test.stopTest();
        System.assertEquals(LEAD_SIZE_ALL, recordList.size(),'The number of records fetched is unexpected');
    }
     
}
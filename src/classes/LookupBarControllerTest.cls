/** Test Class to test the functionality of LookupBarController
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      1.0b
*/
@isTest
global class LookupBarControllerTest {
    public static final Integer ACCOUNTS_SIZE = 20;
    public static final Integer PROPERTYMAP_SIZE = 5;
    public static final Integer PROPERTYMAP_SIZE_INVALID = 1;
    public static final Integer ACCOUNT_SIZE_WITHOUT_LOOOKUP = 5;
    public static final String VALUE_TRUE = 'true';
    public static final String VALUE_FALSE = 'false';
    public static final String OBJECT_NAME = 'Account';
    public static final String FIELD_LABEL = 'Account ID';
    public static final String NOT_EQUAL = 'notEqual';
    public static final String EQUALS = 'equals';
    public static final String NOT_CONTAIN = 'notContain';
    public static final String CONTAINS = 'contains';
    public static final String STARTS_WITH = 'startsWith';
    public static final String LEAD_SIZE = 10;
    public static final String LEAD_SIZE_ALL = 20;

    /* 
    * Method to add the records for testing
    */
    @testsetup
    static void setup() {
        Account[] accountList = new List<Account>();
        for(Integer i = 0 ; i < 20 ; i++) {
            accountList.add(new Account(Name = 'Test Account' + i));
        }
        insert accountList;
        Lead[] leadList = new List<Lead>();
        for(Integer i = 0 ; i < 20 ; i++) {
            leadList.add(new Lead(FirstName = 'Testa '+i,LastName = 'leadb' + i,Company = 'test Company '+i,Status = 'Open - Not Contacted', City='Bhopal'));
        }
        for(integer i = 10 ; i < 20 ; i++) {
            leadList.add(new Lead(FirstName = 'Testa '+i,LastName = 'leadb' + i,Company = 'test Company '+i,Status = 'Open - Not Contacted', City='Mumbai'));
        }
        insert leadList;
    }

    /* 
    * Method to test the functionality of getting the object values from org with all valid data
    * And filter with not equals to criteria
    */  
    @isTest
    static void findByNameWithLookupValueTest() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock(NOT_EQUAL));
        String filter = LookupFilter.appliedLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a','Lead','leadLookup__c',filter);
        Test.stopTest();
        System.assertEquals(ACCOUNTS_SIZE, recordList.size(),'The number of records fetched is unexpected');
    }

     /* 
    * Method to test the functionality of getting the object values from org with all valid data
    * And filter with equal to criteria
    */  
    @isTest
    static void findByNameWithLookupValue_And_Equals_Lookupfilter_Test() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock(EQUALS));
        String filter = LookupFilter.appliedLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a','Lead','leadLookup__c',filter);
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
        String filter = LookupFilter.appliedLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a','Lead','leadLookup__c',filter);
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
        String filter = LookupFilter.appliedLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a','Lead','leadLookup__c',filter);
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
        String filter = LookupFilter.appliedLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName('a','Lead','leadLookup__c',filter);
        Test.stopTest();
        System.assertEquals(LEAD_SIZE_ALL, recordList.size(),'The number of records fetched is unexpected');
    }
     
    /* 
    * Method to test the functionality of getting the object values from org without providing lookup Value
    */  
    @isTest
    static void findByNameWithoutLookupValue() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock());
        String filter = LookupFilter.appliedLookupFilter('Account','leadLookup__c');
        List<sObject> recordList = LookupBarController.findByName(null,'Lead','leadLookup__c',filter);
        Test.stopTest();
        System.assertEquals(ACCOUNT_SIZE_WITHOUT_LOOOKUP,
            recordList.size(),
            'The number of records fetched is unexpected'
        );
    }

    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with all valid data
    */
    @isTest
    static void populatePropertyMapValidObjectAndFieldTest() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock());
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('Contact','AccountId', true);
        Test.stopTest();
        System.assertEquals(PROPERTYMAP_SIZE,
            propertyMap.size(),
            'The number of records fetched is unexpected'
        );
        System.assertEquals(VALUE_TRUE,
            propertyMap.get('Valid'),
            'Field should be valid(true) but returned false'
        );
        System.assertEquals(OBJECT_NAME,
            propertyMap.get('objectName'),
            'The object name returned is invalid'
        );
        System.assertEquals(VALUE_FALSE,
            propertyMap.get('Required'),
            'The field is not required(false) but true is returned'
        );
        System.assertEquals(FIELD_LABEL,
            propertyMap.get('fieldLabel'),
            'The field label returned is unexpected'
        );
    }


    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with invalid object name and valid field name
    */
    @isTest
    static void populatePropertyMapInvalidObjectTest() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock());
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('abc','AccountId', false);
        Test.stopTest();
        System.assertEquals(PROPERTYMAP_SIZE_INVALID,
            propertyMap.size(),
            'The number of records fetched is unexpected'
        );
        System.assertEquals(VALUE_FALSE,
            propertyMap.get('Valid'),
            'Field should be invalid(false) but returned true'
        );    
    }


    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with valid object name and invalid field name
    */
    @isTest
    static void populatePropertyMapValidObjectAndInvalidFieldTest() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock());
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('Contact','abc', false);
        Test.stopTest();
        System.assertEquals(PROPERTYMAP_SIZE_INVALID,
            propertyMap.size(),
            'The number of properties fetched is unexpected'
        );
        System.assertEquals(VALUE_FALSE,
            propertyMap.get('Valid'),
            'Field should be invalid(false) but returned true'
        );
    }


    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with invalid object name and valid field name without lookup
    */
    @isTest
    static void populatePropertyMapValidObjectAndValidFieldNotLookupFieldTest() {
        Test.startTest();
        System.Test.setMock(HttpCalloutMock.class,new LookupBarMock());
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('Contact','Phone', false);
        Test.stopTest();
        System.assertEquals(PROPERTYMAP_SIZE_INVALID,
            propertyMap.size(),
            'The number of properties fetched is unexpected'
        );
        System.assertEquals(VALUE_FALSE,
            propertyMap.get('Valid'),
            'Field should be invalid(false) but returned true'
        );
    }
}

//Response from google if the PIN code is not found



/** Test Class to test the functionality of LookupBarController
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      1.0b
*/
@isTest
private class LookupBarControllerTest {

    /* 
    * Method to add the records for testing
    */
    @testsetup
    static void setup(){
        Account[] accountList = new List<Account>();
        for(Integer i=0;i<20;i++) {
            Account a = new Account(Name='Testa' + i);
            accountList.add(a);
        }
        insert accountList;
    }

    
    // * Method to test the functionality of getting the object values from org with all valid data
       
    @isTest
    static void findByNameWithLookupValueTest() {
        List<sObject> recordList = LookupBarController.findByName('a','Account','Accountid');
        System.assertEquals(20,recordList.size());
    }

     
    // * Method to test the functionality of getting the object values from org without providing lookup Value
    
    @isTest
    static void findByNameWithoutLookupValue(){
        List<sObject> recordList = LookupBarController.findByName(null,'Account','Accountid');
        System.debug('record list =='+recordList);
        System.assertEquals(5,recordList.size());
    }

    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with all valid data
    */
    @isTest
    static void populatePropertyMapValidObjectAndFieldTest(){
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('Contact','AccountId');
        System.assertEquals(4,propertyMap.size());
    }


    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with invalid object name and valid field name
    */
    @isTest
    static void populatePropertyMapInvalidObjectTest(){
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('abc','AccountId');
        System.assertEquals(1,propertyMap.size());
        System.assertEquals('false', propertyMap.get('Valid'));    
    }


    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with valid object name and invalid field name
    */
    @isTest
    static void populatePropertyMapValidObjectAndInvalidFieldTest(){
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('Contact','abc');
        System.assertEquals(1,propertyMap.size());
        System.assertEquals('false', propertyMap.get('Valid'));
    }


    /* 
    * Method to test the functionality of setting the property map for the given object and field by user
    * with invalid object name and valid field name without lookup
    */
    @isTest
    static void populatePropertyMapValidObjectAndValidFieldNotLookupFieldTest(){
        Map<String,String> propertyMap = LookupBarController.populatePropertyMap('Contact','Phone');
        System.assertEquals(1,propertyMap.size());
        System.assertEquals('false', propertyMap.get('Valid'));
    }
}
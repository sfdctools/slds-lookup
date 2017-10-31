public class LookupSearchController {
    @AuraEnabled
    public static List<Account> getAllValueList(String objectName, String fieldName){
        System.debug('objectName====='+objectName);
        System.debug('fieldName====='+fieldName);
        List<sObject> returnList = new List<sObject>();

            String query = 'SELECT id,name FROM '+objectName+' Limit 5';
        	returnList = Database.query(query);
		return returnList;
    }
    
    @AuraEnabled
    public static String getObjectName(String objName,String fieldName){
        System.debug('objName==='+objName);
        System.debug('fieldName==='+fieldName);
        String obj;
		Schema.SObjectType sobj = Schema.getGlobalDescribe().get(objName);
		Schema.DescribeFieldResult f = sobj.getDescribe().fields.getMap().get(fieldName).getDescribe();
		for(Schema.SObjectType reference : f.getReferenceTo()) {
    		obj = reference.getDescribe().getName();
		}
        System.debug('obj ='+obj);
        return obj;
    }
    
	@AuraEnabled
    public static List<sObject> findByName(String lookupValue, String objName) {
        String name = '%' + lookupValue + '%';
        String query =  'SELECT Name From '+objName+' WHERE Name LIKE \'%' + lookupValue + '%\'';
        List<sObject> returnList = Database.query(query);
        System.debug('name ===='+name);
        return returnList;
    }
    @AuraEnabled
    public static Boolean checkRequired(String objectName, String fieldName){
       Boolean isRequired = false;
       Schema.SObjectType sobj = Schema.getGlobalDescribe().get(objectName);
       Map<String,Schema.SObjectField> fieldsMap = sobj.getDescribe().fields.getMap();
        Schema.DescribeFieldResult f = sobj.getDescribe().fields.getMap().get(fieldName).getDescribe();
		isRequired = !f.isNillable();
        System.debug('isRequired ========='+f.isNillable());
    	return isRequired;
    }
    @AuraEnabled
    public static void relationship(String objectName, String fieldName){
        Schema.SObjectType sobj = Schema.getGlobalDescribe().get(objectName);
        Schema.DescribeFieldResult dsr = sobj.getDescribe().fields.getMap().get(fieldName).getDescribe();
		System.debug('Relationship Name: ' + dsr.getRelationshipOrder());
        
    }
    @AuraEnabled
    public static Boolean checkObjAndField(String objectName, String fieldName){
        Boolean flag;
        System.debug('Schema.getGlobalDescribe().keyset() ' +Schema.getGlobalDescribe().keyset());
        System.debug('object =='+objectName+' FieldName == '+fieldName);
        for(String sObj : Schema.getGlobalDescribe().keyset()){
            System.debug('sObj ==='+sObj);
            if(sObj != objectName.toLowerCase()){
                flag = false;
                System.debug('object found');
                
            }
            else{
                System.debug('flag=========='+flag);
                flag = true;
                break;
            }
        }
        if(flag == true){
            for(String sObj : Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().keyset()){
            	if(sObj == fieldName.toLowerCase()){
               		System.debug('field found');
                    flag = false;
				}
        	}
        }
       return flag;
    }   
}
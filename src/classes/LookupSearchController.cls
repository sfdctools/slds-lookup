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
        objName = objName.toLowerCase();
        fieldName = fieldName.toLowerCase();
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
       objectName = objectName.toLowerCase();
       fieldName = fieldName.toLowerCase();
       System.debug('objectName=='+objectName);
       System.debug('fieldName=='+fieldName);
       Boolean isRequired = false;
       Schema.SObjectType sobj = Schema.getGlobalDescribe().get(objectName);
       Map<String,Schema.SObjectField> fieldsMap = sobj.getDescribe().fields.getMap();
       Schema.DescribeFieldResult f = fieldsMap.get(fieldName).getDescribe();
	   isRequired = !f.isNillable();
        System.debug('isRequired ========='+f.isNillable());
        return isRequired;
    }

    @AuraEnabled
    public static Boolean checkObjAndField(String objectName, String fieldName){
        Boolean flag = true;
        objectName = objectName.toLowerCase();
        fieldName = fieldName.toLowerCase(); 
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        Schema.DisplayType fieldType = objType.getDescribe().fields.getMap().get(fieldName).getDescribe().getType();
        if (objType != null && objType.getDescribe().fields.getMap().containsKey(fieldName) && String.valueOf(fieldType) == 'REFERENCE' ){
            return true;
        }
        return false;
    }   
}
public class LookupBarController{
    public static final Map<String, Schema.SObjectType> GLOBALDESCRIBE = Schema.getGlobalDescribe();
/*    @AuraEnabled
    public static List<Account> getAllValueList(String objectName, String fieldName){
        System.debug('objectName====='+objectName);
        System.debug('fieldName====='+fieldName);
        List<sObject> returnList = new List<sObject>();
        String query = 'SELECT id,name FROM '+objectName+' Limit 5';
        returnList = Database.query(query);
        return returnList;
    }*/
/*   
    @AuraEnabled
    public static String getObjectName(String objName,String fieldName){
        objName = objName.toLowerCase();
        fieldName = fieldName.toLowerCase();
        System.debug('objName==='+objName);
        System.debug('fieldName==='+fieldName);
        String obj;
        Schema.SObjectType sobj = GLOBALDESCRIBE.get(objName);
        Schema.DescribeFieldResult f = sobj.getDescribe().fields.getMap().get(fieldName).getDescribe();
        for(Schema.SObjectType reference : f.getReferenceTo()) {
            obj = reference.getDescribe().getName();
        }
        System.debug('obj ='+obj);
        return obj;
    }
*/    
    @AuraEnabled
    public static List<sObject> findByName(String lookupValue, String objName, String fieldName) {
        List<sObject> returnList;
        System.debug('lookupValue'+lookupValue);
        String query ;
        if(lookupValue == null){
            
           
            System.debug('objName====='+objName);
            System.debug('fieldName====='+fieldName);
            //List<sObject> returnList = new List<sObject>();
            query = 'SELECT id,name FROM '+objName+' Limit 5';
            returnList = Database.query(query);
            return returnList;   
        }
        else{
             String name = '%' + lookupValue + '%';
            query =  'SELECT Name From '+objName+' WHERE Name LIKE \'%' + lookupValue + '%\'';
            returnList = Database.query(query);
            System.debug('name ===='+name);
            return returnList;  
                  
        } 
    }
/*    @AuraEnabled
    public static Boolean checkRequired(String objectName, String fieldName){
       objectName = objectName.toLowerCase();
       fieldName = fieldName.toLowerCase();
       System.debug('objectName=='+objectName);
       System.debug('fieldName=='+fieldName);
       Boolean isRequired = false;
       Schema.SObjectType sobj = GLOBALDESCRIBE.get(objectName);
       Map<String,Schema.SObjectField> fieldsMap = sobj.getDescribe().fields.getMap();
       Schema.DescribeFieldResult f = fieldsMap.get(fieldName).getDescribe();
       isRequired = !f.isNillable();
        System.debug('isRequired ========='+f.isNillable());
        return isRequired;
    }
*/
    @AuraEnabled
    public static Map<String,String> objFieldPropertyMap(String objectName, String fieldName){
        Map<String, String> propertyMap = new Map<String, String>();

        objectName = objectName.toLowerCase();
        fieldName = fieldName.toLowerCase(); 
        Schema.SObjectType objType = GLOBALDESCRIBE.get(objectName);
        if (objType != null && objType.getDescribe().fields.getMap().containsKey(fieldName) ){
            propertyMap.put('Valid', 'true');
            Map<String,Schema.SObjectField> fieldsMap = objType.getDescribe().fields.getMap();
            Schema.DisplayType fieldType = fieldsMap.get(fieldName).getDescribe().getType();
            Schema.DescribeFieldResult fieldResult= fieldsMap.get(fieldName).getDescribe();
            if( String.valueOf(fieldType) != 'REFERENCE'){
                propertyMap.put('Valid', 'false');
            }
            else{
                for(Schema.SObjectType reference : fieldResult.getReferenceTo()) {
                    propertyMap.put('objectName', reference.getDescribe().getName());
                }
                Schema.DescribeFieldResult dfs = fieldsMap.get(fieldName).getDescribe();
                propertyMap.put('Required', String.valueOf(!dfs.isNillable()));
            }  
        }
        else{
            propertyMap.put('Valid', 'false');
        }
        return propertyMap;

        
    }   
}
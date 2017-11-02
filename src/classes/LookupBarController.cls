public class LookupBarController{
    public static final Map<String, Schema.SObjectType> GLOBALDESCRIBE = Schema.getGlobalDescribe();
    // Method to get the object values from org
    @AuraEnabled
    public static List<sObject> findByName(String lookupValue, String objName, String fieldName) {
        List<sObject> returnList;
        String query ;
        if(lookupValue == null){
            query = 'SELECT Id,name'
                    +' FROM '+objName
                    +' Limit 5';
            returnList = Database.query(query);
            return returnList;   
        }
        else{
             String name = '%' + lookupValue + '%';
            query =  'SELECT Name'
                    +'  FROM '+objName
                    +' WHERE Name LIKE \'%' + lookupValue + '%\'';
            returnList = Database.query(query);
            return returnList;      
        }
    }

    // Method to set the property map for the given object and field by user
    // This method is also used to check if the values entered bty the user is valid or not
    @AuraEnabled
    public static Map<String,String> objFieldPropertyMap(String objectName, String fieldName){
        Map<String, String> propertyMap = new Map<String, String>();
        Schema.SObjectType objType = GLOBALDESCRIBE.get(objectName);
        if (objType != null && objType.getDescribe().fields.getMap().containsKey(fieldName) ){
            propertyMap.put('Valid', 'true');
            Map<String,Schema.SObjectField> fieldsMap = objType.getDescribe().fields.getMap();
            Schema.DisplayType fieldType = fieldsMap.get(fieldName).getDescribe().getType();
            Schema.DescribeFieldResult fieldResult= fieldsMap.get(fieldName).getDescribe();
            String field =  fieldsMap.get(fieldName).getDescribe().getLabel();
            if( String.valueOf(fieldType) != 'REFERENCE'){
                propertyMap.put('Valid', 'false');
            }
            else{
                for(Schema.SObjectType reference : fieldResult.getReferenceTo()) {
                    propertyMap.put('objectName', reference.getDescribe().getName());
                }
                Schema.DescribeFieldResult dfs = fieldsMap.get(fieldName).getDescribe();
                propertyMap.put('Required', String.valueOf(!dfs.isNillable()));
                propertyMap.put('fieldLabel', field);
            }  
        }
        else{
            propertyMap.put('Valid', 'false');
        }
        return propertyMap;
    }   
}
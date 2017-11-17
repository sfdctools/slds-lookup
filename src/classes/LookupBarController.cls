/** Controller class which will fetch data from org, to be used in LookupBar Component
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      2.0b
*/

public class LookupBarController{
    public static final Map<String, Schema.SObjectType> GLOBALDESCRIBE = Schema.getGlobalDescribe();
    public static final String VALID = 'Valid';
    public static final String VALUE_TRUE = 'true';
    public static final String VALUE_FALSE = 'false';
    public static final String OBJECT_NAME = 'objectName';
    public static final String REQUIRED = 'Required';
    public static final String FIELD_LABEL = 'fieldLabel';
    public static final String FILTERS = 'Filters';
    public static final String LOOKUP_FILTER = 'LookupFilter';

    /* 
    * Method to get the object values from org
    * @param      {String}    lookupValue     {Holds value of the entered text by user}
    * @param      {String}    objName         {Holds value of the Object}
    * @param      {String}    fieldName       {Holds value of the Field }
    */
    @AuraEnabled
    public static List<sObject> findByName(String lookupValue, String objName,String fieldName, String filter) {
        String query =  ' SELECT Id'
                         +    ', Name'
                         +' FROM '+objName;
        if (String.isNotBlank(lookupValue)) {
            String name = '%' + lookupValue + '%';
            query +=' WHERE Name LIKE \'%' + lookupValue + '%\''+' '; 
        }
        query += String.isNotBlank(lookupValue) ? ( filter!='' ?  'AND ' + filter + ' LIMIT 50 ' :  ' LIMIT 50 ') 
                    : ( filter != '' ? ' WHERE ' + filter + ' LIMIT 5 ' : ' LIMIT 5 ');
        return Database.query(query);
    }

    /* Method to set the property map for the given object and field by user
    * This method is also used to check if the values entered bty the user is valid or not
    * @param      {String}    objectName      {Holds value of the entered Object}
    * @param      {String}    fieldName       {Holds value of the entered field}
    */
    @AuraEnabled
    public static Map<String,String> populatePropertyMap(String objectName, String fieldName, Boolean applyFilters) {
        
        Map<String, String> propertyMap = new Map<String, String>();
        Schema.SObjectType objType = GLOBALDESCRIBE.get(objectName);
        if (objType != null && objType.getDescribe().fields.getMap().containsKey(fieldName)) {
            propertyMap.put(VALID, VALUE_TRUE);
            Map<String,Schema.SObjectField> fieldsMap = objType.getDescribe().fields.getMap();
            Schema.DisplayType fieldType = fieldsMap.get(fieldName).getDescribe().getType();
            Schema.DescribeFieldResult fieldDescribe = fieldsMap.get(fieldName).getDescribe();
            String field =  fieldDescribe.getLabel();
            if ( fieldType != Schema.DisplayType.REFERENCE ){
                propertyMap.put(VALID, VALUE_FALSE);
            } else {
                for(Schema.SObjectType reference : fieldDescribe.getReferenceTo()) {
                    propertyMap.put(OBJECT_NAME, reference.getDescribe().getName());
                    break;
                }
                Schema.DescribeFieldResult dfs = fieldsMap.get(fieldName).getDescribe();
                propertyMap.put(REQUIRED, String.valueOf(!dfs.isNillable()));
                propertyMap.put(FIELD_LABEL, field);
                Type filterExtention = Type.forName(LOOKUP_FILTER);
                if(applyFilters == true){
                    if(filterExtention == null){
                        propertyMap.put(FILTERS, 
                            'Extension not found,'
                            +' Please install extension for lookup filters, or set attribute appled filters as false'
                            );  
                    } else{
                        propertyMap.put(FILTERS, LookupFilter.getLookupFilter(objectName,fieldName));    
                    }
                    
                }
            }  
        } else {
            propertyMap.put(VALID, VALUE_FALSE);
        }
        return propertyMap;
    }    
}
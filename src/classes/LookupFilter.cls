/** Class which will get the lookup Filters, to be used in LookupBar Component
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      2.0b
*/
public with sharing class LookupFilter {
    public static final String VALUE_TRUE = 'true';
    public static final String VALUE_FALSE = 'false';
    public static final String EQUALS = 'equals';
    public static final String NOT_EQUAL = 'notEqual';
    public static final String CONTAINS = 'contains';
    public static final String NOT_CONTAIN = 'notContain';
    public static final String STARTS_WITH = 'startsWith';
    public static final String CONTENT_TYPE = 'Content-type';
    public static final String APPLICATION_JSON = 'application/json';
    public static final String AUTHORIZATION = 'Authorization';
    public static final String BEARER = ' Bearer ';
    public static final String BASE_ENDPOINT = 'callout:authenticate/services/data/v41.0/tooling/query?q=';

    /* Method to manually create Boolean Filters
    * @param      {String}    objectName      {Holds value of the entered Object}
    * @param      {String}    fieldName       {Holds value of the entered field}
    */
    public static String createBooleanFilter(String boolFilter, list<LookupFilter.FilterItemsObj> filterItems) {
        if(filterItems.size() > 1) {
            if(boolFilter == null) {
                boolFilter = '';
                for(integer j = 1 ; j <= filterItems.size() ; j++) {
                    boolFilter = boolFilter + ' ' + String.valueOf(j) + ' ' + 'AND';
                }
                boolFilter = boolFilter.removeEnd('AND');   
            }
        }
        return boolFilter;
    }

    /* Method to get the lookup filters for the given object and field by user
    * @param      {String}    objectName      {Holds value of the entered Object}
    * @param      {String}    fieldName       {Holds value of the entered field}
    */
    public static String getLookupFilter( String objectName, String fieldName ) {
        String session_id = UserInfo.getSessionId(), boolFilter = '', filterCondition = '', fieldId, query;
        integer filterIndex = 0;
        Metadata metaObj = new Metadata();
        HttpRequest req = new HttpRequest();
        req.setHeader(CONTENT_TYPE, APPLICATION_JSON);
        req.setHeader(AUTHORIZATION, BEARER + session_id);
        Http http = new Http();
        req.setMethod('GET');
        query = 'SELECT Id '
                + 'FROM CustomField '
                +'WHERE developerName= \'' + fieldName.removeEnd('__c') + '\'';
        String endpoint = BASE_ENDPOINT + EncodingUtil.urlEncode(query, 'UTF-8') ; 
        req.setEndPoint(endpoint);
        HTTPResponse resp = new HTTPResponse();
        try {
            resp = http.send(req);    
        } catch(System.CalloutException e) {
            return 'Error in processing :- ' + e.getMessage(); 
        }
        String customFieldResults = resp.getBody();
        Customfieldwrapper CustomfieldwrapperObj = new Customfieldwrapper();
        CustomfieldwrapperObj = (Customfieldwrapper)JSON.deserialize(customFieldResults, Customfieldwrapper.class);
        for(AttributeObj att : CustomfieldwrapperObj.records){
            fieldId = att.id;
        }
        query = 'SELECT Metadata '
                + 'FROM Lookupfilter '
                +'WHERE developerName= \''+objectName+'_'+fieldId+'\'';
        endpoint = BASE_ENDPOINT + EncodingUtil.urlEncode(query, 'UTF-8');
        req.setEndPoint(endpoint);
        HTTPResponse resp2 = new HTTPResponse();
        try {
            resp2 = http.send(req);    
        } catch(System.CalloutException e) {
            return 'Error in processing :- '+e.getMessage();
        }
        String lookupfilterjson = resp2.getBody();
        lookupFilterWrapper lookupFilterWrapperObj = new lookupFilterWrapper();
        lookupFilterWrapperObj = (lookupFilterWrapper)JSON.deserialize(lookupfilterjson,lookupFilterWrapper.class);
        for(RecordObj rec : lookupFilterWrapperObj.records) {
            metaObj = rec.Metadata;
        }
        if(metaObj.active == false) {
            return '';
        }
        boolFilter = metaObj.booleanFilter;
        boolFilter = createBooleanFilter(boolFilter,metaObj.filterItems);
        String field, operation,value;
            for(FilterItemsObj filter : metaObj.filterItems) {
                field = filter.field;
                filterIndex++;
                operation = filter.operation;
                value = filter.value == null ? filter.valueField : filter.value;
                Map<String,String> operatorMap = new Map<String,String> {
                         EQUALS     =>  field   +   '='+'\''+value+'\'',
                      NOT_EQUAL     =>  field   +   '!=' + '\''+value+'\'',
                       CONTAINS     =>  field   +   ' LIKE \'%'+value+'%\'',
                    NOT_CONTAIN     =>  '(NOT ' +   field   +   ' LIKE \'%'+value+'%\')',
                    STARTS_WITH     =>  field   +   ' LIKE \''+value+'%\''
                };
                if(value == VALUE_TRUE || value == VALUE_FALSE) {
                    operatorMap.put(operation,  operatorMap.get(operation).replace('\'', ''));
                }
                if(operatorMap.containsKey(operation)) {
                    if(operation != EQUALS && operation != NOT_EQUAL) {
                        if(operation == NOT_CONTAIN) {
                            filterCondition = operatorMap.get(operation);
                        }
                        if(operation == STARTS_WITH) {
                            filterCondition = operatorMap.get(operation);  
                        } 
                        else {
                            filterCondition = operatorMap.get(operation);   
                        }
                    } else {
                        filterCondition = operatorMap.get(operation);
                    }
                }
                boolFilter = boolFilter!=null ? boolFilter.replace(String.valueOf(filterIndex), filterCondition)
                    : filterCondition;
        } 
        return ' ('+boolFilter+')';
    }   

    /* Wrapper Class for getting the metadata for lookup filters from tooling api
    */
    public class lookupFilterWrapper {
        public List<RecordObj> records;
    }

    public class RecordObj {
        public Metadata Metadata;
    }

    public class Metadata {
        public String booleanFilter;
        public List<FilterItemsObj> filterItems;
        public Boolean active;
    }

    public class FilterItemsObj {
        public String field;
        public String operation;
        public String value;
        public String valueField;
    }

    /* Wrapper Class for getting the field Id for lookup field from tooling api
    */
    public class Customfieldwrapper {
        public List<AttributeObj> records;
    }

    public class AttributeObj {
        public String id;
    } 
}
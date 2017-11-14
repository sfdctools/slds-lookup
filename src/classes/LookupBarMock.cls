/** Mock responses for Test Class to test the functionality of LookupBarController
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      1.0b
*/
global with sharing class LookupBarMock implements HttpCalloutMock{
    public static final String CUSTOM_FIELD = 'customField';
    public static final String METADATA = 'metadata_';
    public static final String METADATA1 = 'metadata';
    public static final String NOT_EQUAL = 'notEqual';
    public static final String EQUALS = 'equals';
    public static final String NOT_CONTAIN = 'notContain';
    public static final String CONTAINS = 'contains';
    public static final String STARTS_WITH = 'startsWith';
    public static final String FIELD = 'Lead.City';
    public static final String VALUE = 'Mumbai';
    public static final String CONTENT_TYPE = 'Content-Type';
    public static final String APPLICATION_JSON = 'application/json';
    public static final String AUTHORIZATION = 'Authorization';
    public static final String BEARER = ' Bearer ';
    public static final String FIELD_ID = '00N7F00000AXC2PUAX';
    public static final String LOOKUP_FILTER_ID = '0DG7F000000Uw9hWAC';
    public static final String VALUE_FALSE = 'false';
    public static final String VALUE_TRUE = 'true';
    public static final String ENTITY_TYPE_NAME_CUSTOMFIELD = 'CustomField';
    public static final String ENTITY_TYPE_NAME_LOOKUPFILTER = 'LookupFilter';

    String type = '';
    global LookupBarMock() {
        this(NOT_EQUAL);
    }
    global LookupBarMock(String type) {
        this.type = type;
    }
    HttpResponse res = new HttpResponse();
    String response_str = '';
    static final Map<String, String> RESPONSE_MAP = new Map<String,String>{
            CUSTOM_FIELD                 =>      '{'
                                                +    '"size": 1,'
                                                +    '"totalSize": 1,'
                                                +    '"done": '+VALUE_TRUE+','
                                                +    '"queryLocator": null,'
                                                +    '"entityTypeName": "'+ENTITY_TYPE_NAME_CUSTOMFIELD+'",'
                                                +    '"records": ['
                                                +        '{'
                                                +            '"attributes": {'
                                                +                '"type": "'+ENTITY_TYPE_NAME_CUSTOMFIELD+'",'
                                                +               ' "url": "/services/data/v41.0/tooling/sobjects/'+ENTITY_TYPE_NAME_CUSTOMFIELD+'/'+FIELD_ID+'"'
                                                +            '},'
                                                +            '"Id": "'+FIELD_ID+'"'
                                                +        '}'
                                                +    ']'
                                                +'}',

            METADATA + NOT_EQUAL      =>         '{'
                                                +    '"size": 1,'
                                                +    '"totalSize": 1,'
                                                +    '"done": '+VALUE_TRUE+','
                                                +    '"queryLocator": null,'
                                                +    '"entityTypeName": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +    '"records": ['
                                                +        '{'
                                                +            '"attributes": {'
                                                +               ' "type": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +               ' "url": "/services/data/v41.0/tooling/sobjects/'+ENTITY_TYPE_NAME_LOOKUPFILTER+'/'+LOOKUP_FILTER_ID+'"'
                                                +            '},'
                                                +            '"Metadata": {'
                                                +               ' "booleanFilter": null,'
                                                +                '"filterItems": ['
                                                +                    '{'
                                                +                        '"field": "'+FIELD+'",'
                                                +                        '"operation": "'+NOT_EQUAL+'",'
                                                +                        '"value": "'+VALUE+'",'
                                                +                        '"valueField": null'
                                                +                    '}'
                                                +                '],'
                                                +                '"active": '+VALUE_TRUE+','
                                                +                '"description": null,'
                                                +                '"errorMessage": null,'
                                                +                '"infoMessage": null,'
                                                +                '"isOptional": '+VALUE_FALSE+''
                                                +            '}'
                                                +       ' }'
                                                +    ']'
                                                +'}',
            METADATA + EQUALS         =>         '{'
                                                +    '"size": 1,'
                                                +    '"totalSize": 1,'
                                                +    '"done": '+VALUE_TRUE+','
                                                +    '"queryLocator": null,'
                                                +    '"entityTypeName": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +    '"records": ['
                                                +        '{'
                                                +            '"attributes": {'
                                                +               ' "type": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +               ' "url": "/services/data/v41.0/tooling/sobjects/'+ENTITY_TYPE_NAME_LOOKUPFILTER+'/'+LOOKUP_FILTER_ID+'"'
                                                +            '},'
                                                +            '"Metadata": {'
                                                +               ' "booleanFilter": null,'
                                                +                '"filterItems": ['
                                                +                    '{'
                                                +                        '"field": "'+FIELD+'",'
                                                +                        '"operation": "'+EQUALS+'",'
                                                +                        '"value": "'+VALUE+'",'
                                                +                        '"valueField": null'
                                                +                    '}'
                                                +                '],'
                                                +                '"active": '+VALUE_TRUE+','
                                                +                '"description": null,'
                                                +                '"errorMessage": null,'
                                                +                '"infoMessage": null,'
                                                +                '"isOptional": '+VALUE_FALSE+''
                                                +            '}'
                                                +       ' }'
                                                +    ']'
                                                +'}',
            METADATA + NOT_CONTAIN     =>        '{'
                                                +    '"size": 1,'
                                                +    '"totalSize": 1,'
                                                +    '"done": '+VALUE_TRUE+','
                                                +    '"queryLocator": null,'
                                                +    '"entityTypeName": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +    '"records": ['
                                                +        '{'
                                                +            '"attributes": {'
                                                +               ' "type": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +               ' "url": "/services/data/v41.0/tooling/sobjects/'+ENTITY_TYPE_NAME_LOOKUPFILTER+'/'+LOOKUP_FILTER_ID+'"'
                                                +            '},'
                                                +            '"Metadata": {'
                                                +               ' "booleanFilter": null,'
                                                +                '"filterItems": ['
                                                +                    '{'
                                                +                        '"field": "'+FIELD+'",'
                                                +                        '"operation": "'+NOT_CONTAIN+'",'
                                                +                        '"value": "o",'
                                                +                        '"valueField": null'
                                                +                    '}'
                                                +                '],'
                                                +                '"active": '+VALUE_TRUE+','
                                                +                '"description": null,'
                                                +                '"errorMessage": null,'
                                                +                '"infoMessage": null,'
                                                +                '"isOptional": '+VALUE_FALSE+''
                                                +            '}'
                                                +       ' }'
                                                +    ']'
                                                +'}',
            METADATA + CONTAINS      =>          '{'
                                                +    '"size": 1,'
                                                +    '"totalSize": 1,'
                                                +    '"done": '+VALUE_TRUE+','
                                                +    '"queryLocator": null,'
                                                +    '"entityTypeName": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +    '"records": ['
                                                +        '{'
                                                +            '"attributes": {'
                                                +               ' "type": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +               ' "url": "/services/data/v41.0/tooling/sobjects/'+ENTITY_TYPE_NAME_LOOKUPFILTER+'/'+LOOKUP_FILTER_ID+'"'
                                                +            '},'
                                                +            '"Metadata": {'
                                                +               ' "booleanFilter": null,'
                                                +                '"filterItems": ['
                                                +                    '{'
                                                +                        '"field": "'+FIELD+'",'
                                                +                        '"operation": "'+CONTAINS+'",'
                                                +                        '"value": "o",'
                                                +                        '"valueField": null'
                                                +                    '}'
                                                +                '],'
                                                +                '"active": '+VALUE_TRUE+','
                                                +                '"description": null,'
                                                +                '"errorMessage": null,'
                                                +                '"infoMessage": null,'
                                                +                '"isOptional": '+VALUE_FALSE+''
                                                +            '}'
                                                +       ' }'
                                                +    ']'
                                                +'}',
             METADATA + STARTS_WITH   =>         '{'
                                                +    '"size": 1,'
                                                +    '"totalSize": 1,'
                                                +    '"done": '+VALUE_TRUE+','
                                                +    '"queryLocator": null,'
                                                +    '"entityTypeName": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +    '"records": ['
                                                +        '{'
                                                +            '"attributes": {'
                                                +               ' "type": "'+ENTITY_TYPE_NAME_LOOKUPFILTER+'",'
                                                +               ' "url": "/services/data/v41.0/tooling/sobjects/'+ENTITY_TYPE_NAME_LOOKUPFILTER+'/'+LOOKUP_FILTER_ID+'"'
                                                +            '},'
                                                +            '"Metadata": {'
                                                +               ' "booleanFilter": null,'
                                                +                '"filterItems": ['
                                                +                    '{'
                                                +                        '"field": "'+FIELD+'",'
                                                +                        '"operation": "'+STARTS_WITH+'",'
                                                +                        '"value": "b",'
                                                +                        '"valueField": null'
                                                +                    '}'
                                                +                '],'
                                                +                '"active": '+VALUE_TRUE+','
                                                +                '"description": null,'
                                                +                '"errorMessage": null,'
                                                +                '"infoMessage": null,'
                                                +                '"isOptional": '+VALUE_FALSE+''
                                                +            '}'
                                                +       ' }'
                                                +    ']'
                                                +'}'                                                                                                                                 
        };

    global HTTPResponse respond(HTTPRequest req) {
        String endpoint = req.getEndpoint();
        if(endpoint.contains(CUSTOM_FIELD)){
            response_str = RESPONSE_MAP.get(CUSTOM_FIELD);
        }
        if(endpoint.contains(METADATA1)){
           response_str =  RESPONSE_MAP.get(METADATA + type);
        }
        res.setBody(response_str);
        res.setHeader(CONTENT_TYPE, APPLICATION_JSON);
        res.setHeader(AUTHORIZATION, BEARER+UserInfo.getSessionId());
        return res;
    }
   
}
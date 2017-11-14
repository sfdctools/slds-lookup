/** JS class that contains all the utility methods for the component
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      2.0b
*/

({  
    /*
    * Function will execute each time the page is loaded
    * This method will set the properties in the properties map
    * @param      {Object}    component     {Component to get and set values}
    * @param      {Object}    event         {Holds event}
    * @param      {Object}    helper        {Helper class}      
    */
    initialize:function(component, event, helper) {
        var action = helper.getValue(component,"c.populatePropertyMap");
        var applyFilters = helper.getValue(component,"v.applyFilters");
        action.setParams({
            "objectName" : helper.getValue(component,"v.objectName").toLowerCase(), 
             "fieldName" : helper.getValue(component,"v.fieldVal").toLowerCase(), 
          "applyFilters" : applyFilters
        });
        action.setCallback(this,function(a){
            if(a.getState() == "SUCCESS"){
                helper.setValue(component, "v.propMap", a.getReturnValue()); 
                var propMap = helper.getValue(component,"v.propMap");
                if (propMap.Valid == "false") {
                    return false;
                }
                if(helper.getValue(component,"v.applyFilters") == true){
                    if(propMap.Filters.indexOf("Error") != -1){
                        helper.setValue(component,"v.alert","true");
                    }        
                }
                helper.setValue(component,"v.isReq",propMap.Required);
                helper.getValue(component,"v.label") || helper.setValue(component,"v.label",propMap.fieldLabel);
                helper.setValue(component,"v.objectName",propMap.objectName);
                if(applyFilters == true){
                    helper.setValue(component,"v.filter",propMap.Filters);    
                } 
            } else {
                console.error(a.getError()[0].message);
            }
        });
        $A.enqueueAction(action);
    },

    /*
    * This function will load the initial values for the list.
    * @param      {Object}    component     {Component to get and set values}
    * @param      {Object}    event         {Holds event}
    * @param      {Object}    helper        {Helper class}      
    */
    fetchList : function(component, event, helper) {
        helper.setValue(component,"v.close","true");
        var lookupVal = component.find("txtLookup").get("v.value");
        var obj1 = helper.getValue(component,"v.objectName");
        var field1 = helper.getValue(component,"v.fieldVal");
        
        var action = helper.getValue(component,"c.findByName");
        action.setParams({
                "objName" : obj1.toLowerCase(),
            "lookupValue" : lookupVal,
              "fieldName" : field1,
                 "filter" : helper.getValue(component,"v.filter")
          
        });
        action.setCallback(this, function(a) {
            if (a.getState() == "SUCCESS") {
                var values = helper.setValue(component,"v.valuelist", a.getReturnValue());  
                if (values.length > 5) {
                    $A.util.addClass(component.find("card"), 'FixDivSize');
                } else {
                    $A.util.removeClass(component.find("card"), 'FixDivSize');
                }  
            } else {
                console.error(a.getError()[0].message);
            }
            
        });
        $A.enqueueAction(action);
    },

    /* 
    * Method sets the values in the look-up field and set the ID and name of the selected element 
    * @param      {Object}    component     {Component to get and set values}
    * @param      {Object}    event         {Holds event}
    * @param      {Object}    helper        {Helper class}      
    */
    setValuesToField: function(component, event, helper){
        helper.setValue(component,"v.close","true");
        helper.setValue(component,"v.valuelist",[]);
        component.find("txtLookup").set("v.value",event.target.getAttribute("data-value"));
        var myEvent = $A.get("e.c:LookupDataUpdateEvent");
        myEvent.setParams({
              "lookupId"  :  event.target.getAttribute("data-id"), 
            "lookupName"  :  event.target.getAttribute("data-value")
        });
        myEvent.fire();
    },

    /* 
    * Method for hiding the div
    * @param      {Object}    component     {Component to get and set values}
    * @param      {Object}    event         {Holds event}
    * @param      {Object}    helper        {Helper class}      
    */
    onClose : function(component, event, helper){
        helper.setValue(component,"v.close","false");
        component.find("txtLookup").set("v.value",'');
        helper.setValue(component,"v.valuelist",[]);
    }
})
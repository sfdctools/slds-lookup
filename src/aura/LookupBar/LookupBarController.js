({  
    // Function will execute each time the page is loaded
    // This method will set the properties in the properties map
    initialize:function(component, event, helper) {
        var action = component.get("c.objFieldPropertyMap");
        action.setParams({
            "objectName" : helper.getHelper(component,"v.objectName"), 
             "fieldName" : helper.getHelper(component,"v.fieldval"), 
        });
        action.setCallback(this,function(a){
            if(a.getState() == "SUCCESS"){
                helper.setHelper(component, "v.propMap", a.getReturnValue()); 
                var propMap = helper.getHelper(component,"v.propMap");
                if(propMap.Valid == "false"){
                    helper.setHelper(component,"v.alert","true");
                }
                else{
                    var req = helper.setHelper(component,"v.isReq",propMap.Required);
                    if(helper.getHelper(component,"v.label")==''){
                        helper.setHelper(component,"v.label",propMap.fieldLabel);
                    }
                    var obj = helper.setHelper(component,"v.objectName",propMap.objectName);
                }
            }
            else{
                alert("From server: " + a.getReturnValue());
            }
            
        });
        $A.enqueueAction(action);
    },

    // This function will load the initial values for the list.
    doInit : function(component, event, helper) {
        helper.setHelper(component,"v.close","true");
        var lookupVal = component.find("txtLookup").get("v.value");
        var obj1 = helper.getHelper(component,"v.objectName");
        var field1 = helper.getHelper(component,"v.fieldval");
        var action = helper.getHelper(component,"c.findByName");
        action.setParams({
                "objName" : obj1.toLowerCase(),
              "fieldName" : field1.toLowerCase(),
            "lookupValue" : lookupVal
        });
        action.setCallback(this, function(a) {
            if(a.getState() == "SUCCESS"){
                helper.setHelper(component,"v.valuelist", a.getReturnValue());    
            }
            else{
                alert("From server: " + a.getReturnValue());
            }
            
        });
        $A.enqueueAction(action);
    },

    // The method loads the list as per the search key entered by the user
    searchKeyChange: function(component, event, helper) {
        var lookupValue = component.find("txtLookup").get("v.value");
        var sob = helper.getHelper(component,"v.objectName"); 
        var field = helper.getHelper(component,"v.fieldval");
        if(lookupValue && lookupValue.trim().length > 2){
            var action = helper.getHelper(component,"c.findByName");
            action.setParams({
                "lookupValue" : lookupValue,
                    "objName" : sob,
                  "fieldName" : field
            });
            action.setCallback(this, function(a) { 
                if(a.getState() == "SUCCESS"){
                    helper.setHelper(component,"v.valuelist", a.getReturnValue());    
                } 
                else{
                    alert("From server: " + a.getReturnValue());
                }   
            });
            $A.enqueueAction(action);
        }  
    },

    // Method sets the values in the look-up field and set the ID and name of the selected element 
    getId: function(component, event, helper){
        helper.setHelper(component,"v.close","true");
        helper.setHelper(component,"v.valuelist",[]);
        component.find("txtLookup").set("v.value",event.target.getAttribute("data-value"));
        var myEvent = $A.get("e.c:LookupKey");
        myEvent.setParams({
            "lookupId": event.target.getAttribute("data-id"), 
            "lookupName": event.target.getAttribute("data-value")
        });
        myEvent.fire();
    },

    // For the function of close
    onClose : function(component, event, helper){
        helper.setHelper(component,"v.close","false");
        component.find("txtLookup").set("v.value",'');
        helper.setHelper(component,"v.valuelist",[]);
    }
})
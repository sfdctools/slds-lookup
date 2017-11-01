({
    initialize:function(component) {
        var obj = component.get("v.objName")
        var field = component.get("v.fieldval");
        var searchTxt = component.find("txtLookup").get("v.value");
        console.log("obj ====",obj);
        console.log("field ====",field);
        var action = component.get("c.objFieldPropertyMap");
        action.setParams({
            "objectName" : obj, 
            "fieldName"  : field, 
        });
        action.setCallback(this,function(a){
            component.set("v.propMap",a.getReturnValue());
            console.log('propMap ==',a.getReturnValue());
            var propMap = component.get("v.propMap");
            console.log("propMap",propMap);
            if(propMap.Valid == "false"){
                console.log('valid ====',propMap.Valid);
                component.set("v.alert","true");
            }
            else{
                var obj = component.set("v.objectName",propMap.objectName);
                var req = component.set("v.isReq",propMap.Required);
            }
        });
        $A.enqueueAction(action);

      
    },
    doInit : function(component, event) {
        component.set("v.close","true");
        var lookupVal = component.find("txtLookup").get("v.value");
        var obj1 = component.get("v.objectName");
        var field1 = component.get("v.fieldval");
        var action = component.get("c.findByName");
        console.log('value obj1 ',obj1);
        console.log('value field',field1);
        console.log('lookupValue ',lookupVal);
        action.setParams({
            "objName": obj1,
            "fieldName" : field1,
            "lookupValue" : lookupVal
        });
        action.setCallback(this, function(a) {
            component.set("v.valuelist", a.getReturnValue());
        });
        component.set("v.flag", "true");
        $A.enqueueAction(action);
    },
    flagValue : function(component, event) {
        component.set("v.flag","false");
    },
    
    searchKeyChange: function(component, event, helper) {
        var lookupValue = component.find("txtLookup").get("v.value");
        var sob = component.get("v.objectName"); 
        var field = component.get("v.fieldval");
        if(lookupValue && lookupValue.trim().length > 2){
            console.log('lookupValue',lookupValue);
            var action = component.get("c.findByName");
            action.setParams({
                "lookupValue": lookupValue,
                "objName" : sob,
                "fieldName" : field
            });
            action.setCallback(this, function(a) {  
                component.set("v.valuelist", a.getReturnValue());
            });
            $A.enqueueAction(action);
        }  
    },
  
    getId: function(component, event){
        component.set("v.close","true");
        component.set("v.flag","false");
        component.find("txtLookup").set("v.value",event.target.getAttribute("data-value"));
        var myEvent = $A.get("e.c:LookupKey");
        myEvent.setParams({
            "lookupId": event.target.getAttribute("data-id"), 
            "lookupName": event.target.getAttribute("data-value")
        });
        myEvent.fire();
    },
   
    onClose : function(component, event){
        component.set("v.close","false");
        component.find("txtLookup").set("v.value",'');
        component.set("v.flag","false");
    }
})
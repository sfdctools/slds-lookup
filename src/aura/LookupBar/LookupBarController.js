({
    initialize:function(component) {
      
        var obj = component.get("v.objName")
        var field = component.get("v.fieldval");
        console.log("obj ====",obj);
        console.log("field ====",field);
        var action = component.get("c.checkObjAndField");
        action.setParams({
            "objectName" : obj, 
            "fieldName"  : field, 
        });
        action.setCallback(this, function(a){
            component.set("v.alert",!a.getReturnValue());
            console.log("alert===",a.getReturnValue());
            
            var action2 = component.get("c.getObjectName");
            action2.setParams({
                objName : obj,
                fieldName: field  
            });
            action2.setCallback(this,function(a){
                component.set("v.objectName",a.getReturnValue());
                var objectName = component.get("v.objectName");
                var action3 = component.get("c.checkRequired");
                action3.setParams({
                    objectName : obj,
                    fieldName  : field 
                });
                action3.setCallback(this, function(a){
                    component.set("v.isReq",a.getReturnValue());
                });
                $A.enqueueAction(action3);
            });
            $A.enqueueAction(action2);
        });
        $A.enqueueAction(action);
  
    },
    doInit : function(component, event) {
        component.set("v.close","true");
        var obj1 = component.get("v.objectName");
        var field1 = component.get("v.fieldval");
        var action = component.get("c.getAllValueList");
        console.log('value obj1 ',obj1);
        console.log('value field',field1);
        action.setParams({
            "objectName": obj1,
            "fieldName" : field1
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
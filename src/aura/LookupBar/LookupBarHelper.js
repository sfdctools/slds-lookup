({  // Helper method for getting the values from page
	getValue : function(component, prop) {
		return component.get(prop);
      
    },

    // Helper method for setting the values to the  page
    setValue : function(component, prop, retVal){
        component.set(prop, retVal);
        return retVal;
    }
    
})
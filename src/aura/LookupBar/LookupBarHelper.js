({  // Helper method for getting the values from page
	getHelper : function(component, prop) {
		return component.get(prop);
      
    },

    // Helper method for setting the values to the  page
    setHelper : function(component, prop, retVal){
        return component.set(prop, retVal);
    }
    
})
/** JS class that contains all the helper methods for the component
* 
* @author       E. Jayaraman Iyer (https://github.com/jayaramaniyer150895)
* @version      1.0b
*/

({
    /*
    * Function to get the value from the component
    * This method will set the properties in the properties map
    * @param      {Object}    component     {Component to get and set values}
    * @param      {Object}    prop          {Value to be returned from the component}
    */
    getValue : function(component, prop) {
		return component.get(prop);
    },
    /*
    * Function to get the value from the component
    * This method will set the properties in the properties map
    * @param      {Object}    component     {Component to get and set values}
    * @param      {Object}    prop          {Property to be set in the component}
    * @param      {Object}    retVal        {Value to be set in the component}
    */
    setValue : function(component, prop, retVal){
        component.set(prop, retVal);
        return retVal;
    }
})
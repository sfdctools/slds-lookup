# slds-lookup
---
slds-lookup is a native Salesforce.com component, completely native and developed in Lightning, to allow users to embed and generate a lookup functionality for lightning pages.

### Features
- 100% native to Salesforce
- Salesforce Lightning and SLDS compatible
- Real-time lookup search results
- Ability to provide [SLDS icons](https://lightningdesignsystem.com/icons/) for search results
- Customizable field label as per user's choice
- Automatically sets the field as required as per the field properties
- **Follows Lookup Filters set on lookup/master-detail fields (Coming soon...)**

### Installation
To use the slds-lookup component in your existing lightning components, either of the two approaches can be followed -
- Install the [unmanaged package **beta**](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t7F000002CgXR) and follow the sample code to include the slds-lookup component
- [Download the source code]() and create new components with the same name in your org directly.
If using an IDE, paste the downloaded files in your ``` src ``` folder. Once done, deploy the code to server and follow the sample code instructions to include the slds-lookup component

### Sample Code
The following code demonstrates the code that would integrate the slds-lookup component in your existing lightning components
```html
<c:LookupBar objName="Employee__c"
    fieldVal="Project__c"
    icon="standard:entity_milestone"
    label="Related Project"/>
```
##### Attribute usage

Attribute Name | Required? | Details | Default Value
------------ | ------------- | ------------ | -------------
``` objName ``` | Yes | API Name of the object on which the lookup field exists |
``` fieldName ``` | Yes | API Name of the lookup field to be displayed |
``` icon ``` | No | Name of the icon to be displayed for the lookup results. The naming convention is similar to the one followed by the [```<lightning:icon>```](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/aura_compref_lightning_icon.htm) component. If not specified, no icon would be displayed |
``` label ``` | No | If specified, the label provided as an attribute will be displayed as a label to the lookup. Else, the label set in Salesforce would be used | Field label from Salesforce
| ``` applyFilters ``` | No | **Coming Soon!** Boolean value that justifies whether the lookup filters should be applied to the search results or not | false

### Known Issues & Limitations
* Error alert is shown on initial load even though the object name and field name is valid
* The field list doesn’t disappear on focus out, use times icon for hiding list

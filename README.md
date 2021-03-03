<!-- Output copied to clipboard! -->


<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 0; WARNINGs: 0; ALERTS: 14.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>
<a href="#gdcalert10">alert10</a>
<a href="#gdcalert11">alert11</a>
<a href="#gdcalert12">alert12</a>
<a href="#gdcalert13">alert13</a>
<a href="#gdcalert14">alert14</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>


<h1>Flow Event Launcher</h1>
<h2>Launch flows from Enhanced Lightning Grid (and more)</h2>

launch a Flow from a row or list button, and have that flow open as a pop-up window overlay (modal).

<h2>Introduction</h2>
The Enhanced Lightning Grid component from Salesforce Labs is a phenomenal component that enables creating a custom related-list table with:

1. Row-Level Buttons with icons
2. Row-Level Action (drop-down button)
3. List-Level Buttons with icons
4. List-Level Actions
5. Multi-Select with List-Level buttons/actions

One of the common questions we’ve seen posted online is - how can I launch a flow from buttons on Enhanced Lightning Grid **(ELG)** components.
You could use the lightning event (e.force:navigateToURL) to navigate to a flow page, but this navigates away from the page, which may not be what you want.
We’ve created the FlowEvent Launcher **(FEL)** to launch flows from ELG as a popup (modal):

<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

![alt_text](images/image1.png "image_tooltip")


<h2>Installing the Flow Event Launcher</h2>
There are two ways to install the Flow Event Launcher:

1. Clone the code in this repository, and push it to your Salesforce Org
2. Install the pre-packaged component using the following links
    1. Install to Sandbox: 
 

    2. Install to Production: 
 

<h2>How to use Flow Event Launcher</h2>
There are two steps to set up and use the FEL on any lightning page:

1. Drag the FlowLauncher component on to the page. It will be invisible, though it’s sitting there listening for a Lightning Event, which will tell it to jump into action \
(note: while on the Lightning App Builder, the component will appear to add some white-space where you placed it, but when viewing a page, it will be fully invisible) \

2. Configure the Sortable Grid action to invoke the FEL component and to pass in required information.

<h2>Configuring the Enhanced Lightning Grid</h2>
The crucial part of making the FlowEventListener respond and open the flows will be to configure the Enhanced Lightning Grid properly.

When you click the New button In the actions related list of the Sortable Data Grid page, the below page shows up. We’ll walk you through each field to make sure the setup process is as clear as can be:
<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")

1. **Name**\
   Select a name for the Event - this will show up on the button
2. **SDG**\
   is the lookup to the Sortable Grid you are adding
3. **Event**\
  This is the Lightning Event that pressing the button will fire.  \
  - If you deployed our code directly to your org, use: e.c:FlowEvent \
  - If you used our pre-packaged component, use: e.praxis:FlowEvent \

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")

4. **Action Order** \
   If you create multiple actions, this determines the order buttons appear in the table.
5. **Required checkboxes \
   You can ensure that only users that have Create/Edit/Delete permissions to the displayed object will see the button   
6. **Action Type** \
   You can select the following options:
    a. Row: the action will appear on each row in the action drop-down button 
    b. List: the action will appear on the table’s header in the action drop-down button
    c. Row Button: the action will appear as a distinct button on each row
    d. List Button: the action will appear as a distinct button on the table’s header
    e. List Multi-Select: same as List Button, but will only be active when records are selected
7. **Event Payload** \
   This is where we define what flow gets launched and other related information. Details below. \

8. **Icon** \
   You can select any icon from the Lightning Design System library, available here: \
   [https://www.lightningdesignsystem.com/icons/](https://www.lightningdesignsystem.com/icons/)

<h2>The Event Payload</h2>
The event payload is entered in a JSON format (example below). \
The component accepts the following attributes:

1. **Ids (Required)** \
   A valid list of Salesforce Id’s for the SObjects(s) on the Enhanced Lightning Grid that was selected. EGL support the following variables: 
     a. #id# - passes the id of the row (you will only use this in row-level actions)
     b. #ids# - passes the list of ids for the selected rows (you will only use this in list-level actions)
     c. #parentecordId# - passes the id of the parent record (the record viewed on the page)
     d. #AnyAPIName# - you can pass in the value of any field that is displayed in the table, for example #LastModifiedDate#
2. **flowName (Required)** \
   A valid API name of the flow which is expected to be started.
3. **flowVariableName (Required)** \
   The name of the input variable in the launched flow that will accept a **collection of SObjects **that will be passed from the FEL Component.  \
   _Note that the component doesn’t just pass in the selected IDs, it actually queries the records and passes in the records themselves. Therefore, the input variable must be of type ‘Record’ and must have the ‘Allow multiple values (collection)’ checkbox selected, as well as the ‘Available as Input’._
4. **sObject (Required)** \
   The API name of the sObject that will be queried and passed into the flow’s input variable
5. **Fields (Required)**  \
   List of fields on the sObject that are to be retrieved from Salesforce.  The fields can be standard, custom and reference fields. You can use relational fields to obtain values from related parent records through lookup fields. \
   Any field that you plan to use inside the flow must be provided here, or queried separately inside the flow.
6. **forcePageRefresh (Optional)** \
   When using this parameter, the FEL component will cause the page to refresh all data once the flow popup (modal) is closed.  \
   This is done by firing the **_e.Force:refreshView_** event, and is different than a full page-refresh. \

**Sample Event Payload:**

```
{
"ids" : "#ids#",
 "flowName" : "My_Cool_Flow",
 "flowVariableName" : "selectedLines",
 "forcePageRefresh" : true,
 "sObject" : "myCustomObject__c",
     "fields" : [ "Id", "Name",”My_Field__c",”LastModifiedDate”,”OwnerId”,”Owner.FullName”]
}
```

<h2>Flow Requirements</h2>
Your flow must have an input variable that takes a collection of the SObjects records that you are expecting from the Enhanced Lightning Grid.   

<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")

<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


<h2>Putting it all together</h2>


We will quickly outline the steps to make a quick Flow that takes a collection of Contacts and displays them into a Screen Element.  Next, we will show how to setup the Event Flow Listener in a Lightning Page.  Finally, the last step will be to configure the Enhanced Lightning Grid to display both row and list level buttons to communicate with the FlowEventListener and to have your flow launched into a Modal Dialog.

<h3>Create Flow</h3>




*   Create a new Flow and label it whatever you want. 

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")

*   Create your flow to do what ever you like.  In this example you will see a Record Collection, labeled “contactRecords” variable and a Screens element, labeled “Screen Test”.  The screen can be configured to meet your needs to display the Record Collection variable.
    *   It is important to remember when creating the input variable to check the following boxes: “Allow multiple values (collection)” and the “Available for Input”.
*   After creating your screen to display your input variables save the screen and exit.

<h3>Configure Enhanced Lightning Grid</h3>




*   From the Salesforce Application Launcher select “Sortable Data Grids”.  

<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")

*   From the list view create a new Data Grid.  

<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")

*   When entering the information on the Create sortable data grid dialog, remember to select Contacts as the SObject.  In the next image you’ll see an example. 

<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")

*   Once the new grid is created select it from the list view then select the “Related” list view tab.
*   From here you can configure your grid to display the fields you need from the “Fields” list view.   Once that is done you can proceed to create actions.  This is where we will configure for the Flow Event Launcher. 

<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")

*   In this example we will discuss the configuration for the “List Collection” as shown in the image below.  

<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")

*   To ensure that the new grid fires off the correct event we define it in the Event field as “e.c:FlowEvent”.
*   In our example the action is defined as a “List Multi Select”.
*   The event Payload is where we configure the FlowEvent in which the FlowEventListener will listen for.
    *   The five fields: ids, flowName, flowVariableName, sObject and fields are listed in the example payload.  All the fields are required to be configured with valid input.

<h3>Placement of Lightning Component on Lightning Page </h3>




*   In this example the accounts Lightning Page will be updated to add a new tab to the related list called “Example Contacts”.  

<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")

*   The following components have been placed onto the page:
    *   Enhanced Lightning Grid - Click on the component and make any component level configurations that are needed, such as; Visibility, Icon, name of component, etc..
    *   FlowEventListener - UI (less) will not show on the page at run-time.  No configurations needed.

<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")

*   Click Save and then Activate

<h3>Let’s see it in action</h3>


Navigate to the accounts page and click on the “Example Contacts”  related list.  Select as many rows from the Enhanced Lightning Grid.  Press the “List Collection” button at the top right of the list. 

Boom, you should see the flow showing in a modal dialog.



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


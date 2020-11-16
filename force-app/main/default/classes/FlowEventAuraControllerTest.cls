@isTest
public class FlowEventAuraControllerTest {
    @isTest
    private static void getRecordsById_Successful() {
        Contact con = new Contact(LastName='Simpson', FirstName='Homer', Department='Depo 1');
        insert con;

        test.startTest();
        List<Contact> retrievedContacts = FlowEventAuraController.getRecordsById('Contact', new List<String>{'Id', 'LastName', 'FirstName', 'Department'}, 
                        new List<String>{con.Id});
        test.stopTest();

        system.assertEquals(1, retrievedContacts.size(), 'Expected one results but received ' + retrievedContacts.size() + ' results.');
    } 

    @isTest
    private static void getRecordsById_UnSuccessful() {
        Contact con = new Contact(LastName='Simpson', FirstName='Homer', Department='Depo 1');
        insert con;
		boolean caughtException = false;
        test.startTest();
        //adding a bad field so that it generates an error in the  method and returns an empty list
        try {
        	List<Contact> retrievedContacts = FlowEventAuraController.getRecordsById('Contact', new List<String>{'Id', 'LastName2', 'FirstName', 'Department'}, 
                        		new List<String>{con.Id});
        }
        catch(FlowEventAuraController.FlowEventApexException e) {
            caughtException = true;
        }
        
        test.stopTest();
        System.assertEquals(true, caughtException, 'Expecting a FlowEventException and did not receive');
    }
}
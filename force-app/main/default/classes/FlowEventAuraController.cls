public with sharing class FlowEventAuraController {
    public class FlowEventApexException extends Exception {} 

    @AuraEnabled
    public static List<SObject> getRecordsById(String sObjectName, List<String> fields, List<String> idsUsedToRetrieve) {
        List<SObject> returnedRecords = new List<SObject>();
        String dynamicQuery;
        //Normally under most circumstances I won't check for a list/map being empty, I would
        //just iterate over it.  But here I need to know so I don't do any processing because I'm
        //building a list with it and don't really want to check for other things.
        
        //I'm also being stubborn because I don't want to have more than one exit point.  Call it old
        //habits that die hard.  
        if ( !String.isBlank(sObjectName) && fields != null && !fields.isEmpty()  ) {
            dynamicQuery = 'SELECT ';
            for(String field : fields) {
                dynamicQuery += field + ',';
            }
            
            dynamicQuery = (dynamicQuery.contains(',') ) ? dynamicQuery.left(dynamicQuery.length() -1) : dynamicQuery;
            dynamicQuery += ' FROM ' + sObjectName + ' WHERE Id IN :idsUsedToRetrieve';
            
            try {
                returnedRecords = Database.query(dynamicQuery);
            } 
            catch(System.QueryException queryE) {
                system.debug('getRecordsById: Query Exception - ' +  queryE.getMessage());
                throw new FlowEventApexException('\nThere is a SOQL Query issue retrieving the data. Please contact your administrator.\n\nQuery: ' + dynamicQuery);
            }
            catch (System.Exception ex) {
                //I'm not sure throwing an exception here or letting this one bubble up
                //is best.  I'm going to supress with a log message.
                system.debug('getRecordsById: General Exception - ' +  ex.getMessage());
                throw new FlowEventApexException('\n\n General Exception occured.  Please contact your administrator.\n\n' + ex.getMessage());
            }
        }
        return returnedRecords;
   }
}
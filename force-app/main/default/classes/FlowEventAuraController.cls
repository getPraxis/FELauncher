public with sharing class FlowEventAuraController {
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
                
            } catch (Exception e) {
                //I'm not sure throwing an exception here or letting this one bubble up
                //is best.  I'm going to supress with a log message.

                system.debug('getRecordsById: Exception - ' +  e.getMessage());
            }
        }

        return returnedRecords;
   }
}
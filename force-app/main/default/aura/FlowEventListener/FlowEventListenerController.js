({
    handleFlowEvent : function(component, event, helper) {
        let ids = event.getParam('ids');
        let flowName = event.getParam('flowName');
        let flowVariableName = event.getParam('flowVariableName');
        let sObjectName = event.getParam('sObject');
        let sFields= event.getParam('fields');
      
        if ($A.util.isUndefinedOrNull(ids) || $A.util.isUndefinedOrNull(flowName) ||
            $A.util.isUndefinedOrNull(flowVariableName) || $A.util.isUndefinedOrNull(sObjectName) ||
            $A.util.isUndefinedOrNull(sFields)) {
            helper.showErrorToastMessage('Error', 'Invalid Parameters from button click.  Please contact the System Administrator.');
            return;
        }
        component.set('v.isModalOpened', true);   
        helper.getValuesFromSF(component, event,helper);
    },
    
    closeFlowModal : function(component, event) {
    	component.set('v.isModalOpened', false);    
    },
    
    closeModalOnFinish : function(component, event) {
        let status = event.getParam('status');
        if (status === 'FINISHED') {
            component.set('v.isModalOpened', false);
        }
    },
})
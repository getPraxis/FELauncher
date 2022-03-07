({
     getValuesFromSF : function(component, event, helper) {
        let auraController = component.get('c.getRecordsById');
        let flowName = event.getParam('flowName');

        if ( !$A.util.isUndefinedOrNull(auraController) ) {
            let idsParam = event.getParam('ids');
            let arrIds=[];
            if(Array.isArray(idsParam)) {
                arrIds = idsParam;
            }
            else {
                arrIds.push(idsParam);
            }

            let ids =  arrIds[0];
            let flowVariableParam = event.getParam('flowVariableName');
            let arrFlowNames = [];
            if(Array.isArray(flowVariableParam)) {
                arrFlowNames = flowVariableParam;
            }
            else {
                arrFlowNames.push(flowVariableParam);
            }

            let flowVariableName =arrFlowNames[0];
            let sObjectName = event.getParam('sObject');
            let fieldsList= event.getParam('fields');
            let idsList = ids.split(',');
            
            if(arrIds.length != arrFlowNames.length) {
                helper.showErrorToastMessage('Payload configuration issue', 'Please check flowVariableName and Ids for valid configuration');
                component.set('v.isModalOpened',false);
                return;
            }

            auraController.setParams({
                sObjectName         : sObjectName,
                fields              : fieldsList,
                idsUsedToRetrieve   : idsList
            });
          
            auraController.setCallback(this, function(response) {
                let state = response.getState();
                if (state === 'SUCCESS') {
                    let returnedRecords = response.getReturnValue();
                    let  inputVariable = [];
                    inputVariable.push( helper.formatRecordForFlow( returnedRecords, flowVariableName, fieldsList));
                    
                    let flow = component.find('myFlowContainer');
                  

                    for(let i = 1; i < arrFlowNames.length; i++) {
                        inputVariable.push(helper.formatAdditionalFieldNamesValues(arrFlowNames[i],arrIds[i] ));
                        console.log('input variable: ', JSON.stringify(inputVariable));
                    }

                    //No need to throw an error exception handler around this.  Any issues caught in the
                    //flow will be put on the modal.
                    flow.startFlow(flowName, inputVariable );
                
                }
                else if(state === 'ERROR') {
                    helper.showErrorToastMessage('An exception occurred retrieving data from Salesforce.  Check Config.',
                        response.getError()[0].message);
                    component.set('v.isModalOpened',false);
                }
            });
            $A.enqueueAction(auraController);
        }
    },

    formatAdditionalFieldNamesValues : function(variableName, variableValue) {
        if ( !$A.util.isUndefinedOrNull(variableName) && !$A.util.isUndefinedOrNull(variableValue)) {
            let recordFormat = {
                name 	: variableName, 
                type 	: 'String', 
                value 	: variableValue
            };
            return recordFormat;
        }
    },

    formatRecordForFlow : function(records, flowVariableName) {
        if ( !$A.util.isUndefinedOrNull(records) && !$A.util.isUndefinedOrNull(flowVariableName)) {
            let recordFormat = {
                name 	: flowVariableName, 
                type 	: 'SObject', 
                value 	: records
            };
            return recordFormat;
        }
    },

    showErrorToastMessage : function(title, message) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : title,
            message: message,
            duration:'6000',
            key: 'info_alt',
            type: 'error',
            mode: 'dismissable'
        });
        toastEvent.fire();
    }
})
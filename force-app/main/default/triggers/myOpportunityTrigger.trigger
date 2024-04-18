trigger myOpportunityTrigger on Opportunity (before insert, before update,before delete,after update) {
if (trigger.isBefore) {
    if (trigger.isUpdate) {
        for (Opportunity opp : trigger.new) {
            if (opp.Amount < 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }
    
}

if (trigger.isBefore) {
    if (trigger.isDelete) {
        Set<Id> accountIds = new Set<Id>();

        for (Opportunity opp : Trigger.old) {
            if (opp.StageName == 'Closed Won') {
                accountIds.add(opp.AccountId);
            }
        }
        List<Account> relatedAccounts = [SELECT Name,Industry FROM Account WHERE Id IN :accountIds AND Industry = 'Banking'];
        if (relatedAccounts.size()>0) {
            for (Opportunity opp1 : Trigger.old) {
                opp1.addError('Cannot delete closed opportunity for a banking account that is won'); 
            }
            
        }
    }
    
}

if (trigger.isBefore) {
    if (trigger.isUpdate) {
        Set<Id> accountIds = new Set<Id>();

        for (Opportunity opp : Trigger.new) {
                accountIds.add(opp.AccountId);
            }
        List<Contact> relatedContacts = [SELECT Name,Id FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO'];
        if (relatedContacts.size()>0) {
            for (Opportunity opp1 : Trigger.new) {
                for (Contact con : relatedContacts) {
                    opp1.Primary_Contact__c = con.Id;
                }
                //opp1.ContactId = relatedContacts.get(0); 
            }
            
        }
    }
    
}


}
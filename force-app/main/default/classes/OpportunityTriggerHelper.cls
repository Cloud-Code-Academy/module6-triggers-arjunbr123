public with sharing class OpportunityTriggerHelper {

public static void afterUpdate(List<Opportunity> newOpps) {
    for (Opportunity opp : newOpps) {
        if (opp.Amount < 5000) {
            opp.addError('Opportunity amount must be greater than 5000');
        }
    }
}

public static void beforeUpdate(List<Opportunity> newOpps) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newOpps) {
            accountIds.add(opp.AccountId);
        }
        List<Contact> relatedContacts = [SELECT Name,Id FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO'];
        if (relatedContacts.size()>0) {
            for (Opportunity opp1 : newOpps) {
                for (Contact con : relatedContacts) {
                    opp1.Primary_Contact__c = con.Id;
                }
            }          
        }
    }


public static void beforeDelete(List<Opportunity> Opps) {
    Set<Id> accountIds = new Set<Id>();
    for (Opportunity opp : Opps) {
        if (opp.StageName == 'Closed Won') {
            accountIds.add(opp.AccountId);
        }
    }
    List<Account> relatedAccounts = [SELECT Name,Industry FROM Account WHERE Id IN :accountIds AND Industry = 'Banking'];
    if (relatedAccounts.size()>0) {
        for (Opportunity opp1 : Opps) {
            opp1.addError('Cannot delete closed opportunity for a banking account that is won'); 
        }      
    }
}
}
public class AccountTriggerHelper {

public static void beforeInsert(List<Account> newAccounts) {
    for (Account acc : newAccounts) {
        if(acc.Type == null){
            acc.Type = 'Prospect';
            } 
            acc.BillingStreet = acc.ShippingStreet;
            acc.BillingCity = acc.ShippingCity;
            acc.BillingState = acc.ShippingState;
        
            acc.BillingPostalCode = acc.ShippingPostalCode;
            acc.BillingCountry = acc.ShippingCountry;

            if (acc.Phone != NULL && acc.Website!= NULL && acc.Website != NULL) {
                acc.Rating = 'Hot';
                    }
    }
}

public static void afterInsert(List<Account> newAccounts) {
    List<Contact> conList = new List<Contact>();
    for (Account acc : newAccounts){
        conList.add(new Contact(AccountId = acc.Id,LastName = 'DefaultContact',Email = 'default@email.com'));
        }       
insert conList;
}
}

trigger myAccountTrigger on Account (before insert, after insert) {
//Account acc = Trigger.new[0];
if (Trigger.isBefore && Trigger.IsInsert){
    for (Account acc : Trigger.new) {
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
List<Contact> conList = new List<Contact>();
if (Trigger.isAfter) {
    if (Trigger.isInsert) {
        for (Account acc : Trigger.new){
            conList.add(new Contact(AccountId = acc.Id,LastName = 'DefaultContact',Email = 'default@email.com'));
        }       
    }
}
insert conList;

}
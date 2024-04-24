trigger myAccountTrigger on Account (before insert, after insert) {
if (Trigger.isBefore && Trigger.IsInsert){
    AccountTriggerHelper.beforeInsert(Trigger.new);
}

if (Trigger.isAfter && Trigger.IsInsert){
    AccountTriggerHelper.beforeInsert(Trigger.new);
}

if (Trigger.isAfter && Trigger.isInsert) {
    AccountTriggerHelper.afterInsert(Trigger.new);
}
}
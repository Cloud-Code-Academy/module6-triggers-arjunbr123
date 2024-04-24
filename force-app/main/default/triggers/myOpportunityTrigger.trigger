trigger myOpportunityTrigger on Opportunity (before insert, before update,before delete,after update) {
if (Trigger.isBefore && Trigger.isDelete){
    OpportunityTriggerHelper.beforeDelete(Trigger.old);
        } 
if (Trigger.isBefore && Trigger.IsUpdate){
    OpportunityTriggerHelper.beforeUpdate(Trigger.new);
        }     
if (Trigger.isAfter && Trigger.IsUpdate){
    OpportunityTriggerHelper.afterUpdate(Trigger.new);
                }   
}
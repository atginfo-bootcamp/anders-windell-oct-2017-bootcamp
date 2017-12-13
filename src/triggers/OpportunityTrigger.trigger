trigger OpportunityTrigger on Opportunity (after insert, after update) {

	if(Trigger.isAfter && Trigger.isInsert){
		OpportunityTriggerHelper.afterInsert(Trigger.new);
	}else if(Trigger.isAfter && Trigger.isUpdate){
		OpportunityTriggerHelper.afterUpdate(Trigger.new, Trigger.oldMap);
	}

}
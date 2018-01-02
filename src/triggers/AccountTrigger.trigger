trigger AccountTrigger on Account (before insert, before update) {

	if(Trigger.isBefore && Trigger.isInsert){
		AccountTriggerHelper.handleBeforeInsert(Trigger.new);
	}else if(Trigger.isBefore && Trigger.isUpdate){
		AccountTriggerHelper.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
	}
}
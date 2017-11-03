trigger LeadTrigger on Lead (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

	System.debug('Trigger.isInsert: ' + Trigger.isInsert);
	System.debug('Trigger.isUpdate: ' + Trigger.isUpdate);
	System.debug('Trigger.isDelete: ' + Trigger.isDelete);
	System.debug('Trigger.isUndelete: ' + Trigger.isUndelete);


	System.debug('Trigger.isAfter: ' + Trigger.isAfter);
	System.debug('Trigger.isBefore: ' + Trigger.isBefore);

	List<Lead> leads = Trigger.new;
	Map<Id, Lead> leadMap = Trigger.newMap;
	List<Lead> oldLeads = Trigger.old;
	Map<Id, Lead> oldLeadMap = Trigger.oldMap;

	System.debug('Trigger.new ' + Trigger.new);
	System.debug('Trigger.newMap ' + Trigger.newMap);
	System.debug('Trigger.old ' + Trigger.old);
	System.debug('Trigger.oldMap ' + Trigger.oldMap);

	//Common way to choose what code to call and when
	if(Trigger.isBefore && trigger.isInsert){
		//call code to do stuff

		//Change first lead title to 'King' - NO DML NEEDED IN BEFORE CONTEXT
		leads[0].Title = 'King';

	}else if (Trigger.isAfter && trigger.isUpdate){
		//Call different code
		leads[0].Title = leads[0].Id;
	}
}
public without sharing class Utils {

	public static List<SObject> checkForChangedFields(List<SObject> newRecords, Map<Id, SObject> oldRecordMap, String field){
		return checkForChangedFields(newRecords, oldRecordMap, new List<String>{ field });
	}

	public static List<SObject> checkForChangedFields(List<SObject> newRecords, Map<Id, SObject> oldRecordMap, List<String> fields){
		
		List<SObject> changedRecords = new List<SObject>();
		for(SObject newRecord : newRecords){
			SObject oldRecord = oldRecordMap.get((Id)newRecord.get('Id'));
			
			for(String field : fields){
				try {
					if(newRecord.get(field) != oldRecord.get(field)) {
						changedRecords.add(newRecord);
						break;
					}
				} catch (Exception e){
					System.debug('Exception thrown: ' + e);
				}
			}
		}
		

		return changedRecords;
	}

	public static List<SObject> checkForChangedFields(List<SObject> newRecords, Map<Id, SObject> oldRecordMap, String field, String expectedValue){

		List<SObject> changedRecordsOutput = new List<SObject>();
		List<SObject> changedRecords = checkForChangedFields(newRecords, oldRecordMap, field);

		for(SObject record : changedRecords){
			if(record.get(field) == expectedValue){
				changedRecordsOutput.add(record);
			}
		}

		return changedRecordsOutput;
	}
	
}
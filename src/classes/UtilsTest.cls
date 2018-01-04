@isTest
private class UtilsTest {
	
	@isTest static void checkForChangedFieldTest() {
		
		List<Account> accountList = new List<Account>{
			new Account(Id='0011I00000D9wd8', Name='test name'),
			new Account(Id='0011I00000D9wd0', Name='test name')
		};
		Map<Id, Account> oldAccountMap = new Map<Id, Account>{
			'0011I00000D9wd8' => new Account(Id='0011I00000D9wd8', Name='test name CHANGED'),
			'0011I00000D9wd0' => new Account(Id='0011I00000D9wd0', Name='test name')
		};
		String fieldToCheck = 'Name';
		List<SObject> changedRecords = Utils.checkForChangedFields(accountList, oldAccountMap, fieldToCheck);

		System.assertEquals(1, changedRecords.size());
		System.assertEquals(accountList[0], changedRecords[0]);
	}

	@isTest static void checkForChangedFieldsExceptionTest() {
		
		List<Account> accountList = new List<Account>{
			new Account(Id='0011I00000D9wd8', Name='test name'),
			new Account(Id='0011I00000D9wd0', Name='test name', Type='Other')
		};
		Map<Id, Account> oldAccountMap = new Map<Id, Account>{
			'0011I00000D9wd8' => new Account(Id='0011I00000D9wd8', Name='test name CHANGED'),
			'0011I00000D9wd0' => new Account(Id='0011I00000D9wd0', Name='test name')
		};
		List<String> fieldsToCheck = new List<String>{'Name', 'Field Taco', 'Type'};
		List<SObject> changedRecords = Utils.checkForChangedFields(accountList, oldAccountMap, fieldsToCheck);

		System.assertEquals(2, changedRecords.size());
		System.assertEquals(accountList[0], changedRecords[0]);
		System.assertEquals(accountList[1], changedRecords[1]);
	}

	@isTest static void checkForChangedFieldsExpectedValueTest() {
		
		List<Account> accountList = new List<Account>{
			new Account(Id='0011I00000D9wd8', Name='test name', Type='Other'),
			new Account(Id='0011I00000D9wd0', Name='test name', Type='External')
		};
		Map<Id, Account> oldAccountMap = new Map<Id, Account>{
			'0011I00000D9wd8' => new Account(Id='0011I00000D9wd8', Name='test name', Type='Prospect'),
			'0011I00000D9wd0' => new Account(Id='0011I00000D9wd0', Name='test name', Type='Prospect')
		};
		//List<]String> fieldsToCheck = new List<String>{'Name', 'Field Taco', 'Type'};
		List<SObject> changedRecords = Utils.checkForChangedFields(accountList, oldAccountMap, 'Type', 'Other');

		System.assertEquals(1, changedRecords.size());
		System.assertEquals(accountList[0], changedRecords[0]);
	}
	
}
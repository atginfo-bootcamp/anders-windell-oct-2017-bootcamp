@isTest
private class ContactTriggerHelperTests {
	
	private static void stageData(Integer numAccounts, String accountName){

		//Create new accounts based on numAccounts parameter
		//Set up Account fields (i.e. use accounName)
		//Need to insert Accounts to the database
		//Query our accounts from the DB
		//Loop through Accounts
		//Create some Contacts for each Account (AccountId populated)
		//Insert all contacts into the database at once

		List<Account> accounts = new List<Account>();
		for(Integer i = 0;i<numAccounts;i++){
			Account acct = new Account();
			acct.Name = accountName + ' ' + i;
			accounts.add(acct);
		}		

		insert accounts;

		List<Account> accountsFromDB = [
			SELECT Id
			FROM Account
			WHERE Name LIKE :accountName + '%'
		];

		List<Contact> contactList = new List<Contact>();
		for(Account acct : accountsFromDB){

			Integer numberOfContacts = (Integer)(Math.random()*4);

			for(Integer i = 0;i<numberOfContacts;i++){
				Contact contact = new Contact();

				contact.LastName = 'Test Boid';
				contact.AccountId = acct.Id;
				contactList.add(contact);
			}
		}

		insert contactList;

	}

	@isTest static void insertTriggerTest() {
		// Implement test code
		stageData(10, 'Seth');

		List<Account> accountList = [
			SELECT Name, Current_number_of_contacts__c,
				(SELECT LastName, AccountId FROM Contacts)
			FROM Account
		];

		//System.assert(accountList.size() == 10);
		System.assertEquals(accountList.size(), 10, 'You did not insert 10 Accounts');

		for(Account acct : accountList){
			System.debug('For Account ' + acct.Name + ' there are ' + acct.Contacts.size() + ' accounts');
		}


	}
	
	@isTest static void updateTriggerTest() {
		// Implement test code

	}
	
}
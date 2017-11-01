public with sharing class Day4CreateAccountsWithContacts {
	
	public static void createAccountsAndContacts(Integer numAccounts) {

		// Create accounts with contacts associated to them
		// create accounts first, then contacts
		// Loop 'numAccounts' number of times to create 'numAccounts' number of accounts
		// Account name must be "myAccount-"#
		// Insert accounts in bulk (initally do not insert in bulk to experience limits)
		// create 2 contacts for each account
		// Insert contacts in bulk
		// query accounts and subquery contacts
		// Loop through accounts and contacts
		// print out all contacts for each account and the account name

		List<Account> createdAccounts = new List<Account>();
		List<Contact> createdContacts = new List<Contact>();

		for(Integer i = 0; i < numAccounts; i++){
			System.debug('Creating Account ' + i);
			Account createdAccount = createAccount(i+1);
			createdAccounts.add(createdAccount);
		}
		insert createdAccounts;

		for(Account currAccount : createdAccounts){
			createdContacts.add(createContact(currAccount.Id, 1));
			createdContacts.add(createContact(currAccount.Id, 2));
		}

		insert createdContacts;

	}

	public static Account createAccount(Integer accountNameSuffix) {
		String accountName = 'myAccount-' + accountNameSuffix;
		Account myAccount = new Account(Name = accountName);
		System.debug('myAccount: ' + myAccount);
		return myAccount;
	}

	public static Contact createContact(Id accountId, Integer contactNumber) {
		Contact newContact = new Contact(
			FirstName= 'Contact First Name: ' + contactNumber, 
			LastName='Contact Last Name: ' + contactNumber,
			AccountId = accountId
		);
		System.debug('myContact: ' + newContact);
		return newContact;

	}

	public static void queryAndPrintAccountsAndContacts(){

		List<Account> queriedAccounts = [
			SELECT Id, Name, 
				(SELECT Id, FirstName, LastName FROM Contacts)
			FROM Account
			WHERE Name LIKE 'myAccount%'
		];

		for(Account currAccount : queriedAccounts){
			System.debug('Account ' + currAccount.Name);
			for(Contact currContact : currAccount.Contacts){
				System.debug('					Contact ' + currContact.FirstName + ' ' + currContact.LastName);
			}
		}
	}

}
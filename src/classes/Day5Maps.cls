public with sharing class Day5Maps {
	
	public static void example(String name) {

		// For review, this is the syntax of a list
		List<String> namesList = new List<String>();

		namesList.add('Betty');
		namesList.add('Jahn');
		namesList.add('Petre');
		namesList.add('Papper');

		//Keep track if name is found
		Boolean foundName = false;

		for(String currName : namesList){
			if(currName == name){
				System.debug('Found name in list: ' + name);
				foundName = true;
				break;	//Exits out of for loop
			}
		}

		//If foundName is false
		if(!foundName){
			System.debug('Name not found in list: ' + name);
		}

		Map<String, String> namesMap = new Map<String, String>();

		namesMap.put('Betty', 'Betty Boop');
		namesMap.put('Tom', 'Tom Green');
		namesMap.put('Richard', 'Richard Mann');
		namesMap.put('Hugo', 'Hugonormous');

		if(namesMap.containsKey(name)){
			System.debug('Found name in map: ' + name);
		}else{
			System.debug('Name not found in map: ' + name);
		}
	}

	public static void associateContactsToAccounts(){
		//Alternate syntax
		//Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name FROM Account]);
		List<Account> accountList = [SELECT Id, Name FROM Account];
		Map<Id, Account> accountMap = new Map<Id, Account>(accountList);

		List<Contact> contacts = [
			SELECT Id, FirstName, LastName, Name, AccountId 
			FROM Contact
		];

		// loop through contacts
		// print out the name of the contact and the account name

		for(Contact currContact : contacts){
			Account parentAccount = accountMap.get(currContact.accountId);

			System.debug('Contact named ' + currContact.Name + ' belongs to Account named ' + parentAccount.Name);
		}

	}
}
public with sharing class Day3ListsAndLoops {
	
	public static void execute(){

		//Create string variable called myName
		String myName = 'Anders'; 

		// Create new empty list called names
		//THIS IS THE PREFERRED WAY TO INITIALIZE
		List<String> names = new List<String>();

		// Create new list with default values
		List<String> students = new List<String>{'Student 1', 'Student 2', 'Student 3'};

		//Alternate syntax for creating a new array (list) with 20 empty items
		String[] employees = new String[20];

		names.add('Anders');
		names.add('Windell');
		names.add('Papa');
		names.add('Bless');


		System.debug('names: ' + names);

		names.remove(3);	//remove item at index 3 which is 'Bless'

		System.debug('names after last element removed ' + names);

		names.remove(names.size()-1);	//dynamically remove last element in array  

		System.debug('names after dynamic removal ' + names);

		Set<String> uniqueNames = new Set<String>();

		uniqueNames.add('Anders');
		uniqueNames.add('Anders');
		uniqueNames.add('Anders');
		uniqueNames.add('Anders');
		uniqueNames.add('Anders');
		uniqueNames.add('Anders');
		uniqueNames.add('Anders');

		//Store the number of items in our set
		Integer setSize = uniqueNames.size();

		System.debug('uniqueNames: ' + uniqueNames);
		System.debug('set size: ' + setSize);
	}


	public static void executeLoops(){

		//for loop takes 3 parameters
		//index variable
		//condition
		//counter variable

		for(Integer i = 0; i < 10; i++){
			System.debug('i: ' + i);

		}


		List<String> names = new List<String>();

		names.add('Anders');
		names.add('Taco');
		names.add('Pizza');
		names.add('FOOD');

		for(Integer i=0;i<names.size();i++){
			System.debug('Name ' + i + ' is ' + names[i]);
			System.debug('Name ' + i + ' is ' + names.get(i));
		}

		//Advanced for loop
		for(String name : names){
			System.debug(name);
		}

	}

	public static void createNewAccount(){

		Account myAccount = new Account();
		myAccount.Name = 'ATG';
		myAccount.Type = 'Prospect';

		System.debug('myAccount before insert ' + myAccount);

		insert myAccount;

		System.debug('myAccount after insert ' + myAccount);
	}

	public static void updateExistingAccount(){

		List<Account> queriedAccounts = [
			SELECT Id, Name, Type 
			FROM Account 
			WHERE Name = 'ATG' LIMIT 1
		];

		System.debug(queriedAccounts);

		if(queriedAccounts.size() > 0){
			Account myAccount = queriedAccounts[0];
			myAccount.Name = 'Better ATG';
			update myAccount;
			System.debug('Updated!');
		}
	}

	public static void updateAccountTypeOnEveryAccount(){
		//1. query all accounts
		// print out all accounts to console
		//2. loop through accounts
		//3. update type to 'Other'
		// print out all updates to console
		//4. update accounts (DML)
		//

		List<Account> queriedAccounts = [
			SELECT Id, Type
			FROM Account
		];

		System.debug('Queried Accounts: ' + queriedAccounts);

		for(Account acct : queriedAccounts){
			acct.Type = 'Other';
		}
		System.debug('Accounts after update: ' + queriedAccounts);

		update queriedAccounts;
	}

}
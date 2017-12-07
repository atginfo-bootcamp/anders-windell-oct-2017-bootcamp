public with sharing class PassByReferenceExample {
	

	public static void execute() {

		Account myAccount = new Account(Name='My Little Pony', Type='Other');
		System.debug('Initial value of my account: ' + myAccount);

		modifyAccount(myAccount);
		System.debug('after calling modifyAccount(): ' + myAccount);

		modifyAccountName(myAccount.Name);
		System.debug('after calling modifyAccountName(): ' + myAccount);

	}

	public static void modifyAccount(Account account){

		account.Name = 'THE NAME WAS CHANGED IN modifyAccount()';
		account.Type = 'Prospect';
	}

	public static void modifyAccountName(String accountName){

		accountName = accountName + ' I CHANGED THE NAME AGAIN';

	}
}
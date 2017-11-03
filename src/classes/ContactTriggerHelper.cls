public with sharing class ContactTriggerHelper {
	
	public static void handleAfterInsert(List<Contact> contacts){
		updateAccountNumberOfContacts(queryAccountsFromContacts(contacts));
	}

	public static void handleAfterUpdate(List<Contact> contacts, Map<Id, Contact> oldContactMap){
		Set<Id> accountIds = new Set<Id>();

		for(Contact contact : contacts){
			Contact oldContact = oldContactMap.get(contact.Id);
			if(oldContact.AccountId != contact.AccountId){
				//the account Id was changed
				if(contact.AccountId != null){
					accountIds.add(contact.AccountId);
				}
				if(oldContact.AccountId != null){
					accountIds.add(oldContact.AccountId);
				}
			}
		}

		updateAccountNumberOfContacts(queryAccounts(accountIds));

	}

	public static void handleAfterDelete(List<Contact> contacts){

	}

	private static List<Account> queryAccountsFromContacts(List<Contact> contacts){

		Set<Id> accountIds = new Set<Id>();
		for(Contact contact : contacts){
			if(contact.AccountId != null){
				accountIds.add(contact.AccountId);
			}
		}

		return queryAccounts(accountIds);

	}

	private static List<Account> queryAccounts(Set<Id> accountIds){
		List<Account> accountList = new List<Account>();

		if(accountIds.size() > 0){
			accountList = [
				SELECT Id, Current_number_of_contacts__c,
				(SELECT Id FROM Contacts)
				FROM Account
				WHERE Id IN :accountIds
			];
		}

		return accountList;
	}

	private static void updateAccountNumberOfContacts(List<Account> accounts){

		if(accounts.size() > 0){

			for(Account account : accounts){
				account.Current_number_of_contacts__c = account.Contacts.size();
			}

			update accounts;
		}	
	}
}
@isTest
private class OpportunityTriggerHelperTest {

	@isTest static void accountWithNoContacts() {

		Account account = createAccount(true);

		Account accountFromQuery = [SELECT Id, (SELECT Id FROM Contacts) FROM Account LIMIT 1];
		System.assert(accountFromQuery.Contacts.size() == 0, accountFromQuery.Contacts.size());

		Opportunity oppty = createOpportunity(account.Id, 'Closed Won', true);

		Account accountFromQuery2 = [SELECT Id, (SELECT Id, Name FROM Contacts), (SELECT Id FROM Contracts) FROM Account LIMIT 1];
		System.assert(accountFromQuery2.Contacts.size() == 1, accountFromQuery2.Contacts.size());
		System.assert(accountFromQuery2.Contacts[0].Name == 'My Little Pony', accountFromQuery2.Contacts[0].Name);

		System.assert(accountFromQuery2.Contracts.size() == 1, accountFromQuery2.Contracts.size());

	}

	@isTest static void accountWithContacts() {
		

	}

	@isTest static void accountWithExistingOpportunity() {
		

	}

	private static Account createAccount(Boolean isInsert){
		Account acct = new Account();

		acct.Name = 'Test Account';

		if(isInsert){insert acct;}

		return acct;
	}

	private static Opportunity createOpportunity(Id accountId, String stageName, Boolean isInsert){
		Opportunity oppty = new Opportunity();

		oppty.AccountId = accountId;
		oppty.CloseDate = System.today();
		oppty.StageName = stageName;
		oppty.Name = 'Test Oppty';

		if(isInsert){insert oppty;}

		return oppty;
	}
	
}
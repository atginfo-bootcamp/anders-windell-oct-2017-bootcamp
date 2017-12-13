public with sharing class OpportunityTriggerHelper {

	public static void afterInsert(List<Opportunity> newOpportunities){
		insertIsClosedWon(newOpportunities);
	}
	public static void afterUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities){
		changedToClosedWon(newOpportunities, oldOpportunities);
	}

	public static void insertIsClosedWon(List<Opportunity> insertedOpportunities){
		System.debug('Inserted Opportunities ' + insertedOpportunities);
		List<Opportunity> oppsToCreateContracts = new List<Opportunity>();
		for(Opportunity opp : insertedOpportunities){
			if(opp.StageName == 'Closed Won'){
				oppsToCreateContracts.add(opp);
			}
		}

		if(oppsToCreateContracts.size() > 0){
			System.debug('Opps To Create Contracts - Insert ' + oppsToCreateContracts);
			createContracts(oppsToCreateContracts);
		}
	}

	public static void changedToClosedWon(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities){
		List<Opportunity> oppsToCreateContracts = new List<Opportunity>();

		System.debug('Changed To Closed Won - New Values ' + newOpportunities);
		System.debug('Changed To Closed Won - Old Values ' + oldOpportunities);

		for(Opportunity opp : newOpportunities){
			if(opp.StageName == 'Closed Won' && opp.StageName != oldOpportunities.get(opp.Id).StageName){
				oppsToCreateContracts.add(opp);
			}
		}

		if(oppsToCreateContracts.size() > 0){
			System.debug('Opps To Create Contracts - Update ' + oppsToCreateContracts);
			createContracts(oppsToCreateContracts);
		}
	}


	public static void createContracts(List<Opportunity> validOpportunities){

		List<Contract> contractsToInsert = new List<Contract>();

		for(Opportunity opp : validOpportunities){
			Contract contract = new Contract();

			contract.AccountId = opp.AccountId;
			contract.StartDate = System.today();
			contract.ContractTerm = 12;

			contractsToInsert.add(contract);
		}

		if(contractsToInsert.size() > 0){
			System.debug('Contracts To Insert ' + contractsToInsert);
			insert contractsToInsert;
			System.debug('Contracts After Insert '+ contractsToInsert);

			createContractRoles(contractsToInsert);
		}
	}

	public static void createContractRoles(List<Contract> contractList){

		System.debug('Contract List Initial ' + contractList);

		Set<Id> accountIdSet = new Set<Id>();
		for(Contract cont : contractList){
			accountIdSet.add(cont.AccountId);
		}

		List<Account> accountList = [SELECT Id, (SELECT Id, AccountId FROM Contacts) FROM Account WHERE Id IN :accountIdSet];

		System.debug('SOQL Query Results ' + accountList);

		Map<Id, Id> accountContactIdMap = new Map<Id, Id>();
		Set<Contact> newContactSet = new Set<Contact>();

		for(Account acct : accountList){
			if(acct.Contacts.size() > 0){
				accountContactIdMap.put(acct.Id, acct.Contacts[0].Id);
				System.debug('Account Added in spot 1');
			}else{
				Contact contact = new Contact();
				contact.FirstName = 'My Little';
				contact.LastName = 'Pony';
				contact.AccountId = acct.Id;

				newContactSet.add(contact);
			}
		}

		System.debug('New Contact Set ' + newContactSet);
		if(newContactSet.size() > 0){
			insert new List<Contact>(newContactSet);

			for(Contact cont : newContactSet){
				accountContactIdMap.put(cont.AccountId, cont.Id);
				System.debug('Account added in spot 2');
			}
		}

		List<ContractContactRole> contactRoleList = new List<ContractContactRole>();
		for(Contract contract : contractList){
			ContractContactRole contactRole = new ContractContactRole();

			System.debug('Contact ID ' + accountContactIdMap.get(contract.AccountId));

			contactRole.ContactId = accountContactIdMap.get(contract.AccountId);
			contactRole.ContractId = contract.Id;
			contactRole.Role = 'Other';
			contactRole.isPrimary = TRUE;


			contactRoleList.add(contactRole);
		}

		if(contactRoleList.size() > 0){
			insert contactRoleList;
		}


	}

}
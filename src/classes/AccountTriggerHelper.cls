public with sharing class AccountTriggerHelper {
	
	public static void handleBeforeInsert(List<Account> newAccounts){
		markAccountAsHot(newAccounts);
	}
	public static void handleBeforeUpdate(List<Account> newAccounts, Map<Id, Account> oldAccountMap){
		if(!changedRecords(newAccounts, oldAccountMap).isEmpty()){
			System.debug('Something changed, re-running code');
			markAccountAsHot(newAccounts);
		}else{
			System.debug('Nothing changed, not running any code');
		}
	}

	private static void markAccountAsHot(List<Account> accounts){
		for(Account account : accounts){
			if(account.AnnualRevenue >= 500000){
				account.Rating = 'Hot';
			}else{
				account.Rating = null;
			}
		}
	}

	private static List<Account> changedRecords(List<Account> newAccounts, Map<Id, Account> oldAccounts){
		List<Account> changedAccounts = new List<Account>();

		for(Account account : newAccounts){
			if(account.AnnualRevenue != oldAccounts.get(account.Id).AnnualRevenue){
				changedAccounts.add(account);
			}
		}

		return changedAccounts;
	}

}
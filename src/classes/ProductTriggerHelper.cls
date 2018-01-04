public with sharing class ProductTriggerHelper {

	public static void handleAfterUpdate(List<Product2> products, Map<Id, Product2> oldProductMap){
		checkIfFieldsChanged(products, oldProductMap);
	}

	private static void checkIfFieldsChanged(List<Product2> products, Map<Id, Product2> oldProductMap){
		//Loop products
		//Determine if product name changed, if so, print to console
		//List<String> trackChanges = new List<String>{'Name', 'Family', 'IsActive'};
		List<String> trackChanges = Constants.getFields();
		List<Product2> changedProducts = (List<Product2>) Utils.checkForChangedFields(products, oldProductMap, trackChanges);

		if(changedProducts.size() > 0){

			User u = [SELECT Id, Name FROM User WHERE Username =: UserInfo.getUsername()];

			List<Product_Change__c> productChangeRecords = new List<Product_Change__c>();
			for(Product2 prod : changedProducts){
				//System.debug('Product Changed ' + prod);

				Product_Change__c productChangeRecord = new Product_Change__c(Product__c = prod.Id, Date_Changed__c = System.now(), Changed_User__c = u.Id);
				productChangeRecords.add(productChangeRecord);
			}

			if(productChangeRecords.size() > 0){
				insert productChangeRecords;
			}
		}

		//List<Product2> changedProductsWithExpectedPF = (List<Product2>) Utils.checkForChangedFields(products, oldProductMap, 'Family', 'Special');

		//for(Product2 product : changedProductsWithExpectedPF){
		//	System.debug('Product family changed to special: ' + product);
		//}
	}

}
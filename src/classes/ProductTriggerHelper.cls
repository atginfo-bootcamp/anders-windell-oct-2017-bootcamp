public with sharing class ProductTriggerHelper {

	public static void handleAfterUpdate(List<Product2> products, Map<Id, Product2> oldProductMap){
		checkIfNameChanged(products, oldProductMap);
	}

	private static void checkIfNameChanged(List<Product2> products, Map<Id, Product2> oldProductMap){
		//Loop products
		//Determine if product name changed, if so, print to console
		List<String> trackChanges = new List<String>{'Name', 'ProductCode', 'fakeField'};
		List<Product2> changedProducts = (List<Product2>) Utils.checkForChangedFields(products, oldProductMap, trackChanges);


		for(Product2 prod : changedProducts){
			System.debug('Product Changed ' + prod);
		}

		List<Product2> changedProductsWithExpectedPF = (List<Product2>) Utils.checkForChangedFields(products, oldProductMap, 'Family', 'Special');

		for(Product2 product : changedProductsWithExpectedPF){
			System.debug('Product family changed to special: ' + product);
		}
	}

	//Old version before moving to use generic utility method
	//private static void checkIfNameChanged(List<Product2> products, Map<Id, Product2> oldProductMap){
	//	//Loop products
	//	//Determine if product name changed, if so, print to console

	//	for(Product2 prod : products){
	//		if(prod.Name != oldProductMap.get(prod.Id).Name){
	//			System.debug('Product Name Changed From ' + oldProductMap.get(prod.Id).Name + ' to ' + prod.Name);
	//		}
	//	}
	//}

	//Becky wants to know if productCode or isActive was changed also



}
public with sharing class ProductTriggerHelper {

	public static void handleAfterUpdate(List<Product2> products, Map<Id, Product2> oldProductMap){
		checkIfNameChanged(products, oldProductMap);
	}

	private static void checkIfNameChanged(List<Product2> products, Map<Id, Product2> oldProductMap){
		//Loop products
		//Determine if product name changed, if so, print to console

		for(Product2 prod : products){
			if(prod.Name != oldProductMap.get(prod.Id).Name){
				System.debug('Product Name Changed From ' + oldProductMap.get(prod.Id).Name + ' to ' + prod.Name);
			}
		}
	}

}
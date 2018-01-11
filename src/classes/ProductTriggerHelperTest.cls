@isTest
private class ProductTriggerHelperTest {
	
	@isTest static void testFieldsChanged() {
		Product2 product = TestUtilities.createProduct('Test Product', true);
		product.Name = 'Changed Name';
		update product;

		List<Product_Change__c> productChangeRecords = [SELECT Id FROM Product_Change__c];

		System.assert(productChangeRecords.size() == 1);

	}

	@isTest static void testFieldsNotChanged() {
		Product2 product = TestUtilities.createProduct('Test Product', true);
		product.ProductCode = 'Updated Product Code';
		update product;

		List<Product_Change__c> productChangeRecords = [SELECT Id FROM Product_Change__c];

		System.assert(productChangeRecords.size() == 0);
	}
	
}
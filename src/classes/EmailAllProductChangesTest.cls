@isTest
private class EmailAllProductChangesTest {
	
	@isTest static void testProductChangeEmailLogCreated() {
		Product2 product = TestUtilities.createProduct('Test Product', true);
		product.Name = 'Changed Name';
		update product;

		Product_Change__c productChangebefore = [SELECT Id, Email_Send_Date__c FROM Product_Change__c LIMIT 1];
		System.debug('Product Changes ' + productChangebefore);

		Test.startTest();
		DateTime future = system.now().addSeconds(5);
		Integer year = future.year();
		Integer month = future.month();
		Integer day = future.day();
		Integer hour = future.hour();
		Integer minute = future.minute();
		Integer second = future.second();
		String strSchedule = second + ' ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
		System.schedule('EmailAllProductChangesTest', strSchedule, new EmailAllProductChanges());
		Database.executeBatch(new EmailAllProductChanges());
		Test.stopTest();

		List<Product_Change_Email_Log__c> emailLogs = [SELECT Id FROM Product_Change_Email_Log__c];
		Product_Change__c productChange = [SELECT Id, Email_Send_Date__c FROM Product_Change__c LIMIT 1];

		System.debug('Email Logs ' + emailLogs);
		System.debug('Product Changes After ' + productChange);

		System.assert(emailLogs.size() == 1, emailLogs);
		System.assert(productChange.Email_Send_Date__c != null);

	}
	
}
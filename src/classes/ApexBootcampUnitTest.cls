@isTest
private class ApexBootcampUnitTest {
	
	@isTest static void test_method_one() {
		// Implement test code
		List<Lead> leadList = [
			SELECT Id
			FROM Lead
			WHERE Title = 'King'
		];

		//System.assert(leadList != null, 'This code doesnt work');

		String idealTitle = 'Queen';
		for(Lead lead : leadList){
			System.assertNotEquals(lead.Title, idealTitle, 'It\'s good to be queen');	
		}

	}
	
	@isTest static void test_method_two() {
		// Implement test code
	}
	
}
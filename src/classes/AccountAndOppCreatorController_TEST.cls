@isTest
private class AccountAndOppCreatorController_TEST {
    

    private static AccountAndOppCreatorController initData() {
        AccountAndOppCreatorController controller = new AccountAndOppCreatorController();
        controller.account.Name = 'Test Name';
        controller.account.AccountNumber = 'Test AccountNumber';
        controller.account.Description = 'Test Description';
        controller.account.Type = 'Other';
        // account type set automatically

        controller.contact.FirstName = 'My Little';
        controller.contact.LastName = 'Pony';
        controller.contact.Salutation = 'Mr.';

        controller.opportunity.Name = 'Opp Name';
        controller.opportunity.Type = 'New Customer';
        // stageName and closedate are set automatically
        
        return controller;
    }


    @isTest static void testControllerInit() {
        // Implement test code
        AccountAndOppCreatorController controller = new AccountAndOppCreatorController();
        
        System.assertNotEquals(null, controller.account);
        System.assertNotEquals(null, controller.contact);
        System.assertNotEquals(null, controller.opportunity);
        System.assertEquals(false, controller.showCreatedDataSection);

        System.assertEquals('Needs Analysis', controller.opportunity.StageName);
        System.assertEquals(Date.today().addDays(30), controller.opportunity.CloseDate);
    }
    
    @isTest static void testAccountNameRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.account.Name = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }
    

    @isTest static void testAccountNumberRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.account.AccountNumber = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }
    /// CONTINUE THIS WITH ALL REQUIRED FIELDS
    @isTest static void testAccountTypeRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.account.Type = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }

    @isTest static void testContactFirstNameRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.contact.FirstName = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }

    @isTest static void testContactLastNameRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.contact.LastName = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }

    @isTest static void testOpportunityTypeRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.opportunity.Type = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }

    @isTest static void testOpportunityStageNameRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.opportunity.StageName = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }

    @isTest static void testOpportunityCloseDateRequired() {
        AccountAndOppCreatorController controller = initData();
        
        controller.opportunity.CloseDate = null;

        controller.saveData();

        System.assertEquals(1, ApexPages.getMessages().size());
        // query accounts, contacts, opps - make sure size = 0
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());
    }
    
    @isTest static void testOppNameDafultsToAccountName() {
        // If opp name is null, should be set to account name

        AccountAndOppCreatorController controller = initData();
        
        controller.opportunity.name = null;

        controller.saveData();

        for(ApexPages.Message message : ApexPages.getMessages()){
        	System.assertEquals('Data Saved Succesfully' , message.getSummary());
        }

        System.assertEquals(controller.savedOpportunity.name, controller.savedAccount.name);
    }

    @isTest static void testOppNameRetainsValue() {
        // ensure that specified opp name is not overwritten

        AccountAndOppCreatorController controller = initData();

        controller.saveData();

        System.assertEquals('Opp Name', controller.savedOpportunity.name);

        for(ApexPages.Message message : ApexPages.getMessages()){
        	System.assertEquals('Data Saved Succesfully' , message.getSummary());
        }
    }

    @isTest static void testIllegalDatabaseEntry() {
        // ensure that specified opp name is not overwritten

        AccountAndOppCreatorController controller = initData();

        controller.account.YearStarted = '20402';

        controller.saveData();

        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contact = [SELECT Id FROM Contact];
        List<Opportunity> opportunity = [SELECT Id FROM Opportunity];

        System.assertEquals(0, accounts.size());
        System.assertEquals(0, contact.size());
        System.assertEquals(0, opportunity.size());

        System.assert(ApexPages.getMessages().size() > 0);

    }

    @isTest static void testSuccessPath() {
        // Test that everything was created

        AccountAndOppCreatorController controller = initData();
        System.assertNotEquals(null, controller.account.Name);
        System.assertNotEquals(null, controller.account.AccountNumber);
        System.assertNotEquals(null, controller.account.Description);
        System.assertNotEquals(null, controller.account.Type);
        System.assertNotEquals(null, controller.contact.FirstName);
        System.assertNotEquals(null, controller.contact.LastName);
        System.assertNotEquals(null, controller.contact.Salutation);
        System.assertNotEquals(null, controller.opportunity.Name);
        System.assertNotEquals(null, controller.opportunity.Type);
        System.assertNotEquals(null, controller.opportunity.StageName);
        System.assertNotEquals(null, controller.opportunity.CloseDate);
        System.assertEquals(false, controller.showCreatedDataSection);



        // test that all values were re-initialized
        // test that bottom section of UI is shown
        // test that bottom section of ui shows correct data
        // test that init values were set


    }
}
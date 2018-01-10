global class EmailAllProductChanges implements Schedulable, Database.Batchable<sObject>, Database.Stateful {
	
	public String query;
	public String bodyString = '';
	
	global EmailAllProductChanges() {
		
		//mail = new Messaging.SingleEmailMessage();
	}
	
	//Batchable Methods
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, Date_Changed__c, Changed_User__c, Product__c FROM Product_Change__c WHERE Email_Send_Date__c = null';

		


   		bodyString += 	'<table> ' +
   							'<tr>' +
   								'<th>Product</th>\t' +
   								'<th>Changed Date</th>\t' +
   								'<th>Changed User</th>' +
   							'</tr>';

		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Product_Change__c> scope) {
   		System.debug('PRODUCT CHANGES ' + scope);
		for(Product_Change__c productChange : scope){
			buildBodyString(productChange);
		}

	}
	
	global void finish(Database.BatchableContext BC) {
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		Messaging.reserveSingleEmailCapacity(1);
		List<String> toAddresses = Constants.toAddresses();

		mail.setToAddresses(toAddresses);
		mail.setSenderDisplayName(Constants.getSenderDisplayName());
		mail.setSubject('Changed Products on ' + System.today());
		bodyString += '</table>';
		System.debug('BODY STRING ' + bodyString);
		mail.setHtmlBody(bodyString);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		System.debug('Sent Email');
		afterMessageUpdates();
	}


	public void buildBodyString(Product_Change__c productChangeRecord){
		bodyString += 	'<tr>' +
							'<td> ' + productChangeRecord.Product__c + '</td>\t' +
							'<td> ' + productChangeRecord.Date_Changed__c + '</td>\t' +
							'<td> ' + productChangeRecord.Changed_User__c + '</td>' +
					   	'</tr>';
	}

	public void afterMessageUpdates(){
		System.debug('Entered After Update Work');
		Product_Change_Email_Log__c changeEmailLog = new Product_Change_Email_Log__c();
		changeEmailLog.Date_Sent__c = System.now();
		changeEmailLog.Sent_To__c = '';
		for(String address : Constants.toAddresses()){
			changeEmailLog.Sent_To__c = changeEmailLog.Sent_To__c  + address + '\n';
		}
		changeEmailLog.Email_Body__c = bodyString;

		insert changeEmailLog;


		List<Product_Change__c> productChangeRecords = [SELECT Id, Date_Changed__c, 
																Changed_User__c, Product__c 
														FROM Product_Change__c 
														WHERE Email_Send_Date__c = null];

		for(Product_Change__c record : productChangeRecords){
			record.Email_Send_Date__c = System.now();
			record.Product_Change_Email_Log__c = changeEmailLog.Id;
		}
		update productChangeRecords;
	}


	//Schedulable Methods
	global void execute(SchedulableContext sc){
		Database.executeBatch(new EmailAllProductChanges(), 200);
	}
	
}
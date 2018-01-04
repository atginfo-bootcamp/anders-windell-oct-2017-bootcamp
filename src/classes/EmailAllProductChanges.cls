global class EmailAllProductChanges implements Schedulable, Database.Batchable<sObject>, Database.Stateful {
	
	public String query;
	public String bodyString = '';
	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	
	global EmailAllProductChanges() {
		
	}
	
	//Batchable Methods
	global Database.QueryLocator start(Database.BatchableContext BC) {
		query = 'SELECT Id, Date_Changed__c, Changed_User__c, Product__c FROM Product_Change__c WHERE Email_Send_Date__c = null';

		Messaging.reserveSingleEmailCapacity(2);
		List<String> toAddresses = Constants.toAddresses();
		//List<String> ccAddresses = Constants.ccAddresses();

		mail.setToAddresses(toAddresses);
		//mail.setCcAddresses(ccAddresses);
		mail.setSenderDisplayName(Constants.getSenderDisplayName());
		mail.setSubject('Changed Products on ' + System.today());
		mail.setBccSender(false);


   		bodyString += 	'<table> ' +
   							'<tr>' +
   								'<th>Product</th>' +
   								'<th>Changed Date</th>' +
   								'<th>Changed User</th>' +
   							'</tr>';

		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Product_Change__c> scope) {
		for(Product_Change__c productChange : scope){
			buildBodyString(productChange);
		}
	}
	
	global void finish(Database.BatchableContext BC) {
		bodyString += '</table>';
		mail.setHtmlBody(bodyString);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		updateProductChangeRecords();
		createProductChangeEmailLog();
	}


	public void buildBodyString(Product_Change__c productChangeRecord){
		bodyString += 	'<tr>' +
							'<td> ' + productChangeRecord.Product__c + '</td>' +
							'<td> ' + productChangeRecord.Date_Changed__c + '</td>' +
							'<td> ' + productChangeRecord.Changed_User__c + '</td>' +
					   	'</tr>';
	}

	public void updateProductChangeRecords(){
		
	}

	public void createProductChangeEmailLog(){
		
	}


	//Schedulable Methods
	global void execute(SchedulableContext sc){
		Database.executeBatch(new EmailAllProductChanges(), 200);
	}
	
}
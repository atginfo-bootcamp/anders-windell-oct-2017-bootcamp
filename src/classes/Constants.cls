public with sharing class Constants {
	
	private static final String NAME = 'Name';
	private static final String FAMILY = 'Family';
	private static final String ISACTIVE = 'IsActive';
	private static final String MY_EMAIL_ADDRESS = 'anders.windell@atginfo.com';
	private static final String AUSTINS_EMAIL_ADDRESS = 'austin.turner@atginfo.com';
	private static final String SENDER_DISPLAY_NAME = 'Fake Company';


	public static List<String> getFields(){
		return new List<String>{NAME, FAMILY, ISACTIVE};
	}

	public static List<String> toAddresses(){
		return new List<String>{MY_EMAIL_ADDRESS};
	}

	public static List<String> ccAddresses(){
		return new List<String>{AUSTINS_EMAIL_ADDRESS};
	}

	public static String getSenderDisplayName(){
		return SENDER_DISPLAY_NAME;
	}
}
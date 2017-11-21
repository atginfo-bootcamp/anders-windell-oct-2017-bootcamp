public with sharing class LocationManagement {
	
	public static void createLocationAndEmployees(){
		//Business__c missoulaLocation = createLocation('Missoula', '216 W Main Street\nMissoula, MT 59801', '406-123-4567');
		//upsert missoulaLocation;

		//List<Employee__c> employeeList = new List<Employee__c>();

		//employeeList.add(createEmployee(missoulaLocation, 'Ted', 'Powers', 'Active', 'Janitor'));
		//employeeList.add(createEmployee(missoulaLocation, 'Sandy', 'Cheeks', 'Active', 'Executive'));

		//upsert employeeList;

		Business__c missoulaLocation = createLocation('St. Louis', '216 W Main Street\nMissoula, MT 59801', '406-123-4567');
		upsert missoulaLocation;

		List<Employee__c> employeeList = new List<Employee__c>();

		employeeList.add(createEmployee(missoulaLocation, 'James', 'Blonde', 'Active', 'Janitor'));

		upsert employeeList;
	}

	public static void queryAndLogData(){

		List<Employee__c> employeesByLocationId = getEmployeesByLocationId('a001I000003JWtR');
		System.debug('employeesByLocationId ' + employeesByLocationId);

		List<Employee__c> employeesByLocationName = getEmployeesByLocationName('Missoula');
		System.debug('employeesByLocationName ' + employeesByLocationName);

		Business__c location = getLocationAndEmployees('a001I000003JWtR');
		System.debug('location ' + location);
		System.debug('location subquery ' + location.Employees__r);


	}

	public static Business__c createLocation(String name, String address, String phone){
		return createLocation('Advanced Technology Group', name, address, phone);
	}
	public static Business__c createLocation(String businessName, String name, String address, String phone){
		Business__c location = new Business__c();

		location.Business_Name__c = businessName;
		location.Address__c = address;
		location.Name = name;
		location.Phone_Number__c = phone;

		return location;
	}

	public static Employee__c createEmployee(Business__c location, String firstName, String lastName, String status, String title){
		Employee__c employee = new Employee__c();

		employee.Business_Location__c = location.Id;
		employee.Hire_Date__c = Date.today();
		employee.Status_Date__c = Datetime.now();

		employee.First_Name__c = firstName;
		employee.Last_Name__c = lastName;
		employee.Status__c = status;
		employee.Title__c = title;

		return employee;
	}

	public static List<Employee__c> getEmployeesByLocationId(Id locationId){

		List<Employee__c> employeeList = [
			SELECT Id, Name, Business_Location__c, First_Name__c, Last_Name__c, Status__c, Status_Date__c, Title__c, Hire_Date__c
			FROM Employee__c
			WHERE Business_Location__c = :locationId
		];

		return employeeList;

	}

	public static List<Employee__c> getEmployeesByLocationName(String locationName){

		List<Employee__c> employeeList = [
			SELECT Id, Name, Business_Location__c, First_Name__c, Last_Name__c, Status__c, Status_Date__c, Title__c, Hire_Date__c
			FROM Employee__c
			WHERE Business_Location__r.Name = :locationName
		];

		return employeeList;

	}

	public static Business__c getLocationAndEmployees(Id locationId){

		Business__c location = [
			SELECT Business_Name__c, Name, Address__c, Phone_Number__c,
				(SELECT Id, Name, Business_Location__c, First_Name__c, Last_Name__c, Status__c, Status_Date__c, Title__c, Hire_Date__c
				 FROM Employees__r)
			FROM Business__c
			WHERE Id = :locationId
		];

		return location;

	}

	public static List<Employee__c> getEmployeeByEmployeeId(String employeeId){

		List<Employee__c> employeeList = [
			SELECT Id, Name, Business_Location__c, First_Name__c, Last_Name__c, Status__c, Status_Date__c, Title__c, Hire_Date__c
			FROM Employee__c
			WHERE Name = :employeeId
		];

		return employeeList;

	}

	public static Employee__c transferEmployeeLocation(String employeeId, Id targetLocationId){

		List<Employee__c> transferEmployees = getEmployeeByEmployeeId(employeeId);

		if(transferEmployees.size() > 0){
			transferEmployees[0].Business_Location__c = targetLocationId;
			update transferEmployees[0];
			return transferEmployees[0];
		}

		return null;

	}

	public static void updateStatusDateOnStatusChange(List<Employee__c> employees, Map<Id, Employee__c> oldEmployeeMap) {

		for(Employee__c employee : employees) {
			Employee__c oldEmployee = oldEmployeeMap.get(employee.Id);
			
			if(employee.Status__c != oldEmployee.Status__c) {
				employee.Status_Date__c = Datetime.now();
			}
			
		}

	}


}
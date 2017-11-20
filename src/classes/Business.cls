public with sharing class Business {

	private static String name = 'ATG';
	private String locationName;
	private String address;
	private String phoneNumber;
	private List<Employee> employeeList;


	public Business(String locationName, String address, String phoneNumber) {
		this.locationName = locationName;
		this.address = address;
		this.phoneNumber = phoneNumber;

		this.employeeList = new List<Employee>();
	}

	public void addEmployee(Employee employee){
		addEmployee(new List<Employee>{employee});
	}

	public void addEmployee(List<Employee> employees){
		employeeList.addAll(employees);
	}

	public Boolean removeEmployee(Integer employeeId){
		for(Integer i=0;i<employeeList.size();i++){
			if(employeeList[i].getEmployeeId() == employeeId){
				employeeList.remove(i);
				return true;
			}
		}
		return false;
	}

	public List<Employee> getEmployees(){
		return employeeList;
	}

	public Employee getEmployeeById(Integer employeeId){
		
		for(Employee employee : employeeList){
			if(employee.getEmployeeId() == employeeId){
				return employee;
			}
		}
		return null;
	}

	public static Boolean transferEmployee(Business fromLocation, Business toLocation, Integer employeeId){
		//HINT: Use getEmployeeById
		// Remove employee from fromLocation
		// Add employee to destination location
		// Return true if success, false if employee not found

		Employee transferEmployee = fromLocation.getEmployeeById(employeeId);
		
		if(transferEmployee != null && fromLocation.removeEmployee(employeeId)){
			toLocation.addEmployee(transferEmployee);
			
			if(toLocation.getEmployeeById(employeeId) != null){
				return true;
			}
		}
		return false;
	}

	public void printLocationInfo(Boolean printEmployees){
		System.debug('Company ' + name);
		System.debug('     Located in ' + locationName);
		System.debug('     ' + address);
		System.debug('     ' + phoneNumber);

		if(printEmployees){
			System.debug('');
			System.debug('Current Employee List:');
			for(Employee employee : employeeList){
				employee.printEmployeeInfo();
			}
		}

	}
}
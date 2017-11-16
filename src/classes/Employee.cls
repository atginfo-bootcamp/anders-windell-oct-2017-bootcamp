public with sharing class Employee {

	private static Integer employeeCounter = 1;

	private final Integer employeeId;
	private String title;
	private final String firstName;
	private String lastName;
	private Date hireDate;
	private String status;
	private Datetime statusDate;


	public Employee(String title, String firstName, String lastName) {
		employeeId = employeeCounter;
		employeeCounter++;

		this.title = title;
		this.firstName = firstName;
		this.lastName = lastName;
		this.hireDate = Date.today();
		this.status = 'Active';
		this.statusDate = Datetime.now();
	}

	public Integer getEmployeeId(){
		return employeeId;
	}

	public void printEmployeeInfo(){
		System.debug('          Employee Id: ' + employeeId);
		System.debug('          Employee Name: ' + firstName + ' ' + lastName);
		System.debug('          Employee Title: ' + title);
		System.debug('          Employee Hire Date: ' + hireDate);
		System.debug('          Employee Status: ' + status);
		System.debug('          Employee Status Date: ' + statusDate);
	}
}
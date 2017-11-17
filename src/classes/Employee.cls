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
		//Initialized from the employeeCounter
		employeeId = employeeCounter;
		employeeCounter++;

		//Initialized from parameters
		this.title = title;
		this.firstName = firstName;
		this.lastName = lastName;

		//Initialized with non-user specified values
		this.hireDate = Date.today();
		this.status = 'Active';
		this.statusDate = Datetime.now();
	}

	public Integer getEmployeeId(){
		return employeeId;
	}

	/*
	*	PRINT STATEMENTS
	*/

	public void printEmployeeInfo(){
		System.debug('          Employee Name: ' + firstName + ' ' + lastName);
		System.debug('          Employee Id: ' + employeeId);
		System.debug('          Employee Title: ' + title);
		System.debug('          Employee Hire Date: ' + hireDate);
		System.debug('          Employee Status: ' + status);
		System.debug('          Employee Status Date: ' + statusDate);
	}


	/*
	* 	GETTERS AND SETTERS
	*/
	public void setStatus(String newVal){
		//Valid Status' : Active, Terminated, Suspended
		status = newVal;
		statusDate = Datetime.now();
	}

	public String getStatus(){
		return status;
	}

	public void setLastName(String newName){
		lastName = newName;
	}

	public void setPosition(String newTitle){
		title = newTitle;
	}
}
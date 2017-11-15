/**
* Person Class
* A class is made up of the following three elements:
*
* class level properties
* constructor method
* all other methods
*
*/
public class Person {
	// Static variables are shared across all instances
	private static Boolean isHuman = true;

	// CREATE GETTER AND SETTER METHODS
	private String name;
	private String email;
	private String gender;
	private Double weight;
	private Integer age;
	// CREATE GETTER METHOD
	private final Boolean IS_DEAD;

	public Person(String defaultName) {
		name = defaultName;
		IS_DEAD = FALSE;
	}

	//Overloaded Constructor
	// Person fred = new Person('Fred', 'freddster@hotmail.com');
	public Person(String defaultName, String defaultEmail) {
		name = defaultName;
		email = defaultEmail;
		IS_DEAD = FALSE;
	}

	public Person(String defaultName, String defaultEmail, Boolean defaultIsDead) {
		name = defaultName;
		email = defaultEmail;
		IS_DEAD = defaultIsDead;
	}

	public void print(){
		System.debug('Person name: ' + name);
		System.debug('Person email: ' + email);
		System.debug('Person gender: ' + gender);
		System.debug('Person weight: ' + weight);
		System.debug('Person age: ' + age);
		System.debug('Person isDead: ' + IS_DEAD);
		System.debug('Person isHuman: ' + isHuman);
	}


	//GETTER AND SETTER METHODS
	public void setIsHuman(Boolean isHumanVal) {
		isHuman = isHumanVal;
	}

	public String getName(){
		return name;
	}

	public void setName(String newName) {
		name = newName;
	}

	public String getEmail(){
		return email;
	}

	public void setEmail(String newEmail) {
		email = newEmail;
	}

	public String getGender(){
		return gender;
	}

	public void setGender(String newGender){
		gender = newGender;
	}

	public Double getWeight(){
		return weight;
	}

	public void setWeight(Double newWeight){
		weight = newWeight;
	}

	public Integer getAge(){
		return age;
	}

	public void setAge(Integer newAge){
		age = newAge;
	}

	public Boolean getIsDead(){
		return IS_DEAD;
	}
}
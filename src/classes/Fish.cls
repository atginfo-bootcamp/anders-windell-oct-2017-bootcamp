public with sharing class Fish implements Animal{
	public Fish() {
		
	}

	public void speak(){
		System.debug('The fish goes glub glub glub');
	}

	public void eat(String typeOfFood){
		System.debug('The fish looks sick from eating ' + typeOfFood);
	}

	public void die() {
		System.debug('The first dies... XD');
	}
}
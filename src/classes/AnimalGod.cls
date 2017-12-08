public with sharing class AnimalGod {
	
	public static void handleAnimals(){
		Dog myDog = new Dog();
		Fish myFish = new Fish();

		doAnimalStuff(myDog, 'Cheetos');
		doAnimalStuff(myFish, 'A sock');
	}

	public static void doAnimalStuff(Animal animal, String typeOfFood){
		animal.speak();
		animal.eat(typeOfFood);
	}
}
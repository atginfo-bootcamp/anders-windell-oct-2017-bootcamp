@isTest
public class TestUtilities {
	
	public static Product2 createProduct(String productName, Boolean doInsert) {
		Product2 product = new Product2();
		product.Name = productName;
		product.IsActive = true;

		if(doInsert){insert product;}
		return product;
	}
	
}
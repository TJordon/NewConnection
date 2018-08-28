@isTest

public class OrderTest {


  @isTest private static void OrderControllerTest() {
    Contact contacts;
    List<Contact> contactsList;
    List<Product_Table__c> product;
	Product_Table__c orderProduct = new Product_Table__c();
      
    Org_Configuration__c orgConfig = new Org_Configuration__c();
    orgConfig.Period_Term__c = 10;  
    insert orgConfig; 
      
    Warehouse__c newWarehouse = new Warehouse__c();
    newWarehouse.Name = 'Warehouse';
    insert newWarehouse;
      
    orderProduct.Product_Name__c = 'Google Pixel';
    orderProduct.Product_Description__c= 'Google Pixel';
    orderProduct.Image_Url__c = 'https://img.mvideo.ru/Pdb/30029483b.jpg';
    orderProduct.Unit_Price__c = 2;
    orderProduct.Units_Available__c = 10;
	orderProduct.Added_Date__c = Date.today();
    insert orderProduct;
      
    product = [ SELECT id, Product_Name__c, Product_Description__c, Image_Url__c, Unit_Price__c, Units_Available__c, Added_Date__c 
  				FROM Product_Table__c];     
    System.assertEquals(1, product.size()); 
      
    OrderController controller = new OrderController();
    controller.yourEmail = 'tema@mail.ru';
    controller.yourFirstName = 'FFF';
    controller.yourLastName = 'GGG';
    controller.yourAmount = 2; 
	controller.intId = product[0].id;  
      
    Contact contact = new Contact();
    contact.Email = 'tema@mail.ru';
    contact.FirstName = 'AAA';
    contact.LastName = 'VVV';
    insert contact;
      
    contactsList = [SELECT id, Email, FirstName, LastName
    				FROM Contact];
    System.assertEquals(1, contactsList.size());
      
    contacts = [  SELECT id, Email,  FirstName,  LastName
   					FROM Contact WHERE Email =: 'tema@mail.ru' LIMIT 1];
    System.assertEquals('tema@mail.ru', contacts.Email);
      
	controller.getProduct();
    controller.actionBuy();
  }
    
  @isTest private static void OrderactionBuyTest() {
    Contact contacts;
    List<Contact> contactsList;
    List<Product_Table__c> product;
      
	Product_Table__c orderProduct = new Product_Table__c();
      
    Org_Configuration__c orgConfig = new Org_Configuration__c();
    orgConfig.Period_Term__c = 10;  
    insert orgConfig; 
      
    Warehouse__c newWarehouse = new Warehouse__c();
    newWarehouse.Name = 'Warehouse';
    insert newWarehouse;  
      
    orderProduct.Product_Name__c = 'Google Pixel';
    orderProduct.Product_Description__c= 'Google Pixel';
    orderProduct.Image_Url__c = 'https://img.mvideo.ru/Pdb/30029483b.jpg';
    orderProduct.Unit_Price__c = 2;
    orderProduct.Units_Available__c = 10;
    orderProduct.Added_Date__c = Date.today();  
    insert orderProduct;
      
    product = [ SELECT id, Product_Name__c, Product_Description__c, Image_Url__c, Unit_Price__c, Units_Available__c, Added_Date__c  
  				FROM Product_Table__c];
      
    Contact contact = new Contact();
    contact.Email = 'tema3@mail.ru';
    contact.FirstName = 'AAA';
    contact.LastName = 'VVV';
    insert contact;
      
    OrderController controller2 = new OrderController();
    controller2.yourEmail = 'tema2@mail.ru';
    controller2.yourFirstName = 'FFF';
    controller2.yourLastName = 'GGG';
	controller2.yourAmount = 2; 
	controller2.intId = product[0].id;  
      
    controller2.getProduct();  
    controller2.actionBuy();
      
  }
  @isTest private static void OrderInsertTest() {
    List<Order_Table__c> orderList; 
      
    Order_Table__c order = new Order_Table__c();
    order.Product__c =  'a016F00001ijddhQAA';
    order.Units__c =  3;
    order.Order_Amount__c = 200;
	insert order;
      
    orderList = [ SELECT id, Product__c
  			       FROM Order_Table__c];
    System.assertEquals(1, orderList.size());  
      
    }
}
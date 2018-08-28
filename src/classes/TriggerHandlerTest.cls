@isTest
public class TriggerHandlerTest {
  @isTest private static void TriggerHandlerTest() {
    TriggerHandler handlerTest = new TriggerHandler();
      
     Org_Configuration__c orgConfig = new Org_Configuration__c();
   	 orgConfig.Period_Term__c = 10;  
     insert orgConfig; 
      

     Product_Table__c product = new Product_Table__c();
     product.Product_Name__c = 'Google Pixel';
     product.Product_Description__c= 'Google Pixel';
     product.Image_Url__c = 'https://img.mvideo.ru/Pdb/30029483b.jpg';
     product.Unit_Price__c = 2;
     product.Added_Date__c = Date.today();
     insert product;
      
     List<Product_Table__c> productsList = [ SELECT id, Product_Name__c, Product_Description__c, Image_Url__c, Unit_Price__c, Units_Available__c, Added_Date__c 
     				 							FROM Product_Table__c];
      handlerTest.onBefore(productsList);
      
 }
}
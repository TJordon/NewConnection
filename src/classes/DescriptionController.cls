public class DescriptionController {

 public Id intId {get;set;}   
 public List<Product_Table__c> product {get;set;}


 public DescriptionController(){    
  getUrl();       
  getProduct();
 }

 public void getUrl(){ 
   intId = ApexPages.currentpage().getparameters().get('id');
 }

 public void getProduct(){ //Метод запроса товаров в таблицу
     product = [ SELECT id, Product_Name__c, Product_Description__c, Image_Url__c, Unit_Price__c, Units_Available__c 
                 FROM Product_Table__c WHERE id =: intId ];             
   }
}
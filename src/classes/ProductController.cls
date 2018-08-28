public class ProductController {

  public List<Product_Table__c> productList {get;set;}

  public ProductController(){
    getProducts();
  }

  public void getProducts(){ //Метод запроса товаров в таблицу
    productList = [ SELECT id, Product_Name__c, Product_Description__c, Image_Url__c, Unit_Price__c 
    FROM Product_Table__c LIMIT:1000];               
  }
}
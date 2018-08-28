public class OrderController {
 public string yourEmail { get; set; }
 public string yourFirstName { get; set; }
 public string yourLastName { get; set; }
 public Integer yourAmount { get; set; }
 public Id intId { get;set; } 
 public Boolean flag = false;
 public List<Product_Table__c> product { get;set; }
 public Contact contacts;
 public Contact c;
 public Order_Table__c order;
 public List<Contact> cont {get;set;}

 public OrderController(){    
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

 public void actionBuy(){

     cont = [ SELECT id, Email
     		  FROM Contact LIMIT 100];

     for(Integer i=0; i < cont.size(); i++){
       if(cont[i].Email == yourEmail){
        flag = true;  
        cont[i].FirstName = yourFirstName;
        cont[i].LastName = yourLastName;
        c = cont[i];
        update c;
        break;
      }
    }

    if(flag == false){
      c = new Contact(Email = yourEmail, FirstName = yourFirstName, LastName = yourLastName);
      insert c;
    }
     
    product[0].Units_Available__c = (product[0].Units_Available__c - yourAmount);
    update product;
   
    order = new Order_Table__c();
    order.Product__c =  product[0].id;
    order.Units__c =  yourAmount;
    order.Order_Amount__c = product[0].Unit_Price__c * yourAmount;
    order.Contact__c = c.id;
	insert order;
 }
}
public class TriggerHandler {
    public Boolean flag;
    public List<Warehouse__c> newWarehouseList = new List<Warehouse__c>();
    
    public void onBefore(List<Product_Table__c> products){// Получаем trigger.new в качестве параметра
        List<Warehouse__c> warehouses = Database.query('SELECT id, Period_End__c, Period_Start__c FROM Warehouse__c');
        Org_Configuration__c orgConfig = [ SELECT id, Period_Term__c 
    									   FROM Org_Configuration__c LIMIT:1]; // Запрос к custom setting
        for(Product_Table__c product : products){ // Проверяем новые продукты на соответсивие Warehouse
            flag = false; // Сбрасываем флаг, переходим к проверке следующего продукта
            if(product.Added_Date__c == null){
               product.Added_Date__c = Date.today(); 
            }
            for(Warehouse__c warehouse : warehouses){ // Проверяем продукт на соответсивие имеющимся Warehouse
                if(product.Added_Date__c >= warehouse.Period_Start__c && product.Added_Date__c <= warehouse.Period_End__c){
                    flag = true; // Если есть соответсвие заканчиваем проверку
                    break;
                }else{
                    continue;
                }              
        	}
            if(flag == false){ // Если соответсвий в имеющихся Warehouse нет, проверяем в массиве новых соданных Warehouse
              for(Warehouse__c warehouse : newWarehouseList){
                if(product.Added_Date__c >= warehouse.Period_Start__c && product.Added_Date__c <= warehouse.Period_End__c){
                    flag = true;
                    break;
                }else{
                    continue;
                }              
        	  }    
            }
            
            if(flag == false){// Если соответсвий в массиве новых соданных Warehouse нет, создаем новый Warehouse и добавляем в общий массив
                	Warehouse__c newWarehouse = new Warehouse__c();
                	newWarehouse.Name = 'Warehouse' +' '+ product.Added_Date__c +' '+ (product.Added_Date__c + Integer.valueOf(orgConfig.Period_Term__c));
					newWarehouse.Period_Start__c = product.Added_Date__c;
               		newWarehouse.Period_End__c = product.Added_Date__c + Integer.valueOf(orgConfig.Period_Term__c);
                    newWarehouseList.add(newWarehouse);
                
                }
        }
        if(newWarehouseList.size() > 0 && newWarehouseList.size() != null){
        	insert newWarehouseList;      // Добавляем все новые Warehouse
        }
     	List<Warehouse__c> warehouses2 = Database.query('SELECT id, Period_End__c, Period_Start__c FROM Warehouse__c'); // Заброс к уже обновленным Warehouse, для присвоения id соответсвующим продуктам
        for(Product_Table__c product : products){
            for(Warehouse__c warehouse : warehouses2){
                if(product.Added_Date__c >= warehouse.Period_Start__c && product.Added_Date__c <= warehouse.Period_End__c){
					product.Warehouse__c = warehouse.id;
                    break;
                }else{
                    continue;
                }              
        	}
        }
    }

}
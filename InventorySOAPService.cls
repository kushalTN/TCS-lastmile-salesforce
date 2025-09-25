global class InventorySOAPService {

    // Get product by Name
    webService static Product__c getProductByName(String prodName) {
        return [SELECT Id, Name, Stock_Quantity__c 
                FROM Product__c 
                WHERE Name = :prodName 
                LIMIT 1];
    }

    // Get order by Name
    webService static Order__c getOrderByName(String orderName) {
        return [SELECT Id, Name, Order_Date__c 
                FROM Order__c 
                WHERE Name = :orderName 
                LIMIT 1];
    }
}
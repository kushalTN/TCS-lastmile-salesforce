public with sharing class InventorySOQLSOSL {

    public static void demoQueries() {

        // ==========================
        // 1️⃣ SOQL 
        // ==========================
        // Fetch Product__c records for your products
        List<Product__c> prods = [
            SELECT Id, Name, Stock_Quantity__c 
            FROM Product__c 
            WHERE Name IN ('Headphone', 'Mouse', 'Keyboard', 'Laptop')
        ];
        System.debug('SOQL Product Records: ' + prods);

        // ==========================
        // 2️⃣ SOSL
        // ==========================
        // Search across Product__c for "Laptop"
        List<List<SObject>> results = [
            FIND 'Laptop' IN ALL FIELDS RETURNING Product__c(Name, Stock_Quantity__c)
        ];
        System.debug('SOSL Search Results:');
        for(SObject sObj : results[0]) {
            Product__c p = (Product__c)sObj;
            System.debug('Product Name: ' + p.Name + ', Stock: ' + p.Stock_Quantity__c);
        }
    }
}

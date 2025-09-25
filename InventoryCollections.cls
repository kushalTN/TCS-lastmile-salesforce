public with sharing class InventoryCollections {

    public static void demoCollections() {

        // ==========================
        // 1️⃣ List: Ordered collection
        // ==========================
        List<String> products = new List<String>{'Headphone', 'Mouse', 'Keyboard', 'Laptop'};
        System.debug('Products List: ' + products);

        // ==========================
        // 2️⃣ Set: Unique values, no duplicates
        // ==========================
        Set<String> orders = new Set<String>{'Kushal', 'Kushi'};
        orders.add('Kushal'); // duplicate ignored
        System.debug('Orders Set: ' + orders);

        // ==========================
        // 3️⃣ Map: Key-value pairs
        // ==========================
        // Map of Product Name → Stock Quantity
        Map<String, Integer> stockMap = new Map<String, Integer>{
            'Headphone' => 10,
            'Mouse' => 20,
            'Keyboard' => 15,
            'Laptop' => 5
        };
        System.debug('Product Stock Map: ' + stockMap);

        // Optional: Using Map with SOQL results if Product__c exists
        List<Product__c> prodRecords = [SELECT Id, Name, Stock_Quantity__c 
                                        FROM Product__c 
                                        WHERE Name IN :products];
        Map<Id, Product__c> prodMap = new Map<Id, Product__c>(prodRecords);
        System.debug('Map from SOQL Product Records: ' + prodMap);
    }
}
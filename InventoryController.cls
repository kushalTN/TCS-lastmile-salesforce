// InventoryController.cls
public with sharing class InventoryController {
    @AuraEnabled(cacheable=true)
    public static List<Product__c> getProducts() {
        return [
            SELECT Id, Name, Product_Code__c, Unit_Price__c, Stock_Quantity__c
            FROM Product__c
            ORDER BY Name
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Order__c> getOrders() {
        return [
            SELECT Id, Name, Customer_Name__c, Order_Date__c, Status__c,
                   (SELECT Id, Product__c, Product__r.Name, Quantity__c, Total_Price__c FROM Order_Items__r)
            FROM Order__c
            ORDER BY Order_Date__c DESC
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getOrderStatusCounts() {
        Map<String, Integer> result = new Map<String, Integer>();
        for (AggregateResult ar : [
                SELECT Status__c s, COUNT(Id) c
                FROM Order__c
                GROUP BY Status__c
        ]) {
            result.put( (String)ar.get('s'), Integer.valueOf(((Decimal)ar.get('c')).intValue()) );
        }
        return result;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Decimal> getStockLevels() {
        Map<String, Decimal> result = new Map<String, Decimal>();
        for (Product__c p : [SELECT Name, Stock_Quantity__c FROM Product__c]) {
            result.put(p.Name, p.Stock_Quantity__c == null ? 0 : p.Stock_Quantity__c);
        }
        return result;
    }
}
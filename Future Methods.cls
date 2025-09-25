public class FutureExample {
    @future
    public static void updateStock(Id prodId) {
        Product__c p = [SELECT Stock_Quantity__c FROM Product__c WHERE Id = :prodId];
        p.Stock_Quantity__c += 1;
        update p;
    }
}

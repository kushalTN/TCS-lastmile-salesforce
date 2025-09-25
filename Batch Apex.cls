global class UpdateStockBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Stock_Quantity__c FROM Product__c');
    }
    global void execute(Database.BatchableContext bc, List<Product__c> scope) {
        for (Product__c p : scope) {
            p.Stock_Quantity__c += 10;
        }
        update scope;
    }
    global void finish(Database.BatchableContext bc) {}
}

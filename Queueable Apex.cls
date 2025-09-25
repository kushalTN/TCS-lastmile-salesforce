public class StockQueueable implements Queueable {
    public void execute(QueueableContext context) {
        List<Product__c> prods = [SELECT Stock_Quantity__c FROM Product__c];
        for (Product__c p : prods) {
            p.Stock_Quantity__c += 5;
        }
        update prods;
    }
}

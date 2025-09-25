global class DailyStockUpdate implements Schedulable {
    global void execute(SchedulableContext sc) {
        System.enqueueJob(new StockQueueable());
    }
}

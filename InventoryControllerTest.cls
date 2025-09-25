@isTest
public class InventoryControllerTest {
    @isTest
    static void testGetProductsAndOrders() {
        Product__c prod = new Product__c(Name='Laptop', Product_Code__c='P001', Unit_Price__c=50000, Stock_Quantity__c=10);
        insert prod;

        Order__c ord = new Order__c(Customer_Name__c='John Doe', Order_Date__c=Date.today(), Status__c='Pending');
        insert ord;

        Order_Item__c oi = new Order_Item__c(Order__c=ord.Id, Product__c=prod.Id, Quantity__c=2, Total_Price__c=100000);
        insert oi;

        Test.startTest();
        List<Product__c> products = InventoryController.getProducts();
        List<Order__c> orders = InventoryController.getOrders();
        Test.stopTest();

        System.assert(products.size() > 0, 'Products returned');
        System.assert(orders.size() > 0, 'Orders returned');
    }
}

@RestResource(urlMapping='/inventory/*')
global with sharing class InventoryRestService {

    @HttpGet
    global static void handleGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        // Get the last part of URL to identify endpoint
        String[] pathParts = req.requestURI.split('/');
        String endpoint = pathParts[pathParts.size()-1];

        try {
            if(endpoint == 'products') {
                List<Product__c> products = [SELECT Id, Name, Stock_Quantity__c FROM Product__c];
                res.responseBody = Blob.valueOf(JSON.serialize(products));
                res.statusCode = 200;
            }
            else if(endpoint == 'orders') {
                List<Order__c> orders = [SELECT Id, Name, Order_Date__c FROM Order__c];
                res.responseBody = Blob.valueOf(JSON.serialize(orders));
                res.statusCode = 200;
            }
            else {
                res.statusCode = 400;
                res.responseBody = Blob.valueOf('Invalid endpoint. Use /products or /orders');
            }
        } catch(Exception e) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Error: ' + e.getMessage());
        }
    }
}
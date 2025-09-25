public with sharing class InventoryCallout {
    @AuraEnabled(cacheable=true)
    public static String getExternalInventory() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:InventoryAPI/posts/1'); 
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        return res.getBody();
    }
}
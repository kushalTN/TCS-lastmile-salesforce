public with sharing class OrderItemHandler {
    
    public static void handleAfterInsert(List<Order_Item__c> newItems) {
        Map<Id, Decimal> qtyToSubtract = new Map<Id, Decimal>();
        for (Order_Item__c oi : newItems) {
            if (oi.Product__c != null) {
                Decimal q = oi.Quantity__c == null ? 0 : oi.Quantity__c;
                qtyToSubtract.put(oi.Product__c, qtyToSubtract.get(oi.Product__c) == null ? q : qtyToSubtract.get(oi.Product__c) + q);
            }
        }
        if (!qtyToSubtract.isEmpty()) {
            List<Product__c> prods = [SELECT Id, Stock_Quantity__c FROM Product__c WHERE Id IN :qtyToSubtract.keySet() FOR UPDATE];
            for (Product__c p : prods) {
                p.Stock_Quantity__c = (p.Stock_Quantity__c == null ? 0 : p.Stock_Quantity__c) - qtyToSubtract.get(p.Id);
            }
            update prods;
        }
    }

    public static void handleAfterDelete(List<Order_Item__c> oldItems) {
        Map<Id, Decimal> qtyToAdd = new Map<Id, Decimal>();
        for (Order_Item__c oi : oldItems) {
            if (oi.Product__c != null) {
                Decimal q = oi.Quantity__c == null ? 0 : oi.Quantity__c;
                qtyToAdd.put(oi.Product__c, qtyToAdd.get(oi.Product__c) == null ? q : qtyToAdd.get(oi.Product__c) + q);
            }
        }
        if (!qtyToAdd.isEmpty()) {
            List<Product__c> prods = [SELECT Id, Stock_Quantity__c FROM Product__c WHERE Id IN :qtyToAdd.keySet() FOR UPDATE];
            for (Product__c p : prods) {
                p.Stock_Quantity__c = (p.Stock_Quantity__c == null ? 0 : p.Stock_Quantity__c) + qtyToAdd.get(p.Id);
            }
            update prods;
        }
    }

    public static void handleAfterUpdate(List<Order_Item__c> newItems, Map<Id,Order_Item__c> oldMap) {
        Map<Id, Decimal> qtyDelta = new Map<Id, Decimal>();
        for (Order_Item__c oi : newItems) {
            Order_Item__c old = oldMap.get(oi.Id);
            if (oi.Product__c != null && old.Product__c != null && oi.Product__c == old.Product__c) {
                Decimal delta = (oi.Quantity__c == null ? 0 : oi.Quantity__c) - (old.Quantity__c == null ? 0 : old.Quantity__c);
                qtyDelta.put(oi.Product__c, qtyDelta.get(oi.Product__c) == null ? delta : qtyDelta.get(oi.Product__c) + delta);
            } else {
                if (old.Product__c != null) {
                    Decimal oldQ = old.Quantity__c == null ? 0 : old.Quantity__c;
                    qtyDelta.put(old.Product__c, qtyDelta.get(old.Product__c) == null ? -oldQ : qtyDelta.get(old.Product__c) - oldQ);
                }
                if (oi.Product__c != null) {
                    Decimal newQ = oi.Quantity__c == null ? 0 : oi.Quantity__c;
                    qtyDelta.put(oi.Product__c, qtyDelta.get(oi.Product__c) == null ? newQ : qtyDelta.get(oi.Product__c) + newQ);
                }
            }
        }
        if (!qtyDelta.isEmpty()) {
            List<Product__c> prods = [SELECT Id, Stock_Quantity__c FROM Product__c WHERE Id IN :qtyDelta.keySet() FOR UPDATE];
            for (Product__c p : prods) {
                Decimal change = qtyDelta.get(p.Id) == null ? 0 : qtyDelta.get(p.Id);
                p.Stock_Quantity__c = (p.Stock_Quantity__c == null ? 0 : p.Stock_Quantity__c) - change;
            }
            update prods;
        }
    }
}
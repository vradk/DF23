trigger SellItemTrigger on Sell_Item__c (before insert, before update) {
    new SellItemTriggerHandler().execute();
}
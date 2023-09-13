public with sharing class SellItemTriggerHandler {

    public void execute() {
        switch on Trigger.operationType {
            when BEFORE_INSERT, BEFORE_UPDATE {
                new SellItemService().calculatePricesForGivenItems(Trigger.new);
            }
        }
    }
}
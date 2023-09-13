public with sharing class SellItemService {

    public void calculatePricesForGivenItems(final List<Sell_Item__c> sellItems) {
        PriceCalculatorInjector pcInjector = new PriceCalculatorInjector();
        IPriceCalculatorService pcService;

        for (Sell_Item__c sellItem : sellItems) {
            pcService = pcInjector.getCalculatorService(sellItem);
            if (null == pcService) {
                sellItem.addError(
                        String.format(
                            'Was not possible to find price calculator for {0} price type!',
                            new String[] { sellItem.Price_Type__c }
                        )
                );
            } else {
                sellItem.Price__c = pcService.calculatePrice(sellItem);
            }
        }
    }

    public class SellItemServiceException extends Exception {}
}
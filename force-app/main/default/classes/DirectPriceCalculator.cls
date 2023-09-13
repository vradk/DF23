public with sharing class DirectPriceCalculator implements IPriceCalculatorService{
    public Decimal calculatePrice(final Sell_Item__c sellItem) {
        if (null == sellItem?.Initial_Cost__c) {
            throw new PriceCalculationServiceException('Initial_Cost__c cannot be blank during Direct Price Calculation!');
        }

        return sellItem.Initial_Cost__c * 1.1;
    }
}
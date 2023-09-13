public with sharing class AdvancedPriceCalculator implements IPriceCalculatorService {
    public Decimal calculatePrice(final Sell_Item__c sellItem) {
        Set<String> fieldsToCheck = new Set<String> {'Parameter_A__c', 'Parameter_B__c', 'Initial_Cost__c'};

        for (String sellItemField : fieldsToCheck) {
            if (null == sellItem.get(sellItemField)) {
                throw new PriceCalculationServiceException(
                    String.format(
                        '{0} cannot be blank during Advanced Price Calculation!',
                        new String [] { sellItemField }
                    )
                );
            }
        }

        return sellItem.Initial_Cost__c + 0.25 * sellItem.Parameter_A__c + (sellItem.Parameter_A__c * sellItem.Parameter_B__c);
    }
}
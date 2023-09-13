public with sharing class PriceCalculatorInjector {

    private Map<String, IPriceCalculatorService> priceCalculators;

    public PriceCalculatorInjector() {
        this.getPriceCalculators();
    }

    public IPriceCalculatorService getCalculatorService(final Sell_Item__c sellItem) {
        return this.priceCalculators.containsKey(sellItem.Price_Type__c)
                ? this.priceCalculators.get(sellItem.Price_Type__c)
                : this.priceCalculators.containsKey('Default')
                    ? this.priceCalculators.get('Default')
                    : null;
    }

    private Map<String, IPriceCalculatorService> getPriceCalculators() {
        this.priceCalculators = new Map<String, IPriceCalculatorService>();

        List<DI_Setting__mdt> priceCalculatorsSettings = DISettingSelector.selector.getActiveSettingsByEntities(
                new Set<String> {'SellItemPriceCalculator'}
        );
        Map<String, String> classMappings = getMappingsForDISettings(priceCalculatorsSettings);

        for (String classKey: classMappings.keySet()) {
            this.priceCalculators.put(classKey, (IPriceCalculatorService)Type.forName(classMappings.get(classKey)).newInstance());
        }

        return this.priceCalculators;
    }

    private Map<String, String> getMappingsForDISettings(final List<DI_Setting__mdt> priceCalculatorsSettings) {
        Map<String, String> classMappings = new Map<String, String>();

        for (DI_Setting__mdt settings: priceCalculatorsSettings) {
            classMappings.put(settings.Key__c, settings.Value__c);
        }

        return classMappings;
    }
}
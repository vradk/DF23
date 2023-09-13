public with sharing class DISettingSelector {

    public static DISettingSelector selector = new DISettingSelector();

    public List<DI_Setting__mdt> getActiveSettingsByEntities(final Set<String> entities) {
        return [
                SELECT Id, Entity__c, Key__c, Value__c
                FROM DI_Setting__mdt
                WHERE Entity__c IN :entities
                    AND Is_Active__c = true
        ];
    }
}
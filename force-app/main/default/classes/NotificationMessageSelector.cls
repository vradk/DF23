public with sharing class NotificationMessageSelector {

    public static NotificationMessageSelector selector = new NotificationMessageSelector();

    public List<NotificationMessage__mdt> getMessagesByPageName(final Set<String> pageNames, Datetime timeNow) {
        return [SELECT Id, EndDate__c, FromDate__c, HelpURL__c, IsLink__c,
                        Order__c, Variant__c,
                (SELECT Id, NotificationMessage__c, Order__c, TextContent__c, TextType__c
                FROM NotificationMessageContents__r
                WHERE IsActive__c = true)
                FROM NotificationMessage__mdt
                WHERE Group__c IN :pageNames
                AND FromDate__c <= :timeNow AND EndDate__c >= :timeNow
                ORDER BY Order__c ASC NULLS LAST
        ];
    }
}
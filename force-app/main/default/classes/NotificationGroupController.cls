public with sharing class NotificationGroupController {

    @AuraEnabled
    public static List<NotificationMessage__mdt> getNotificationMessages(final String notificationPage) {
        List<NotificationMessage__mdt> messages = NotificationMessageSelector.selector.getMessagesByPageName(new Set<String> {notificationPage}, Datetime.now());
        return messages;
    }
}
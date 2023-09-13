import { LightningElement, api, track } from 'lwc';
import getNotificationMessages from '@salesforce/apex/NotificationGroupController.getNotificationMessages';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const NOTIFICATION_STYLES = [
    'alert',
    'mt-2',
]

export default class NotificationSection extends NavigationMixin(LightningElement) {
    @api notificationPage;

    @track notifications = [];

    connectedCallback() {
        getNotificationMessages({notificationPage: this.notificationPage})
            .then(response => {
                this.notifications = response.map(elem => {
                    elem.Variant__c = elem.Variant__c?.toLowerCase();
                    elem.cssStyle = [...NOTIFICATION_STYLES, `alert-${elem.Variant__c}`].join(' ');
                    elem.NotificationMessageContents__r?.sort((a,b) => a.Order__c - b.Order__c);
                    return elem;
                });
            })
            .catch(error => {
                console.log('error = ', error);
                let toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: error?.body?.message ? error.body.message : error,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);
            })
    }

    handleNotificationRedirect(event) {
        const foundNotification = this.notifications.find(elem => elem.Id === event.currentTarget.dataset.notificationId);

        if (foundNotification?.IsLink__c) {
            this[NavigationMixin.Navigate]({
                    type: 'standard__webPage',
                    attributes: {
                        url: foundNotification.HelpURL__c,
                    }
                },
                true // Replaces the current page in your browser history with the URL
            );
        }
    }
}
import { LightningElement, api } from 'lwc';

import NAME_FIELD from "@salesforce/schema/ToDo__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/ToDo__c.Description__c";
import CATEGORY_FIELD from "@salesforce/schema/ToDo__c.Category__c";
import STATUS_FIELD from "@salesforce/schema/ToDo__c.Status__c";
import PRIORITY_FIELD from "@salesforce/schema/ToDo__c.Priority__c";
import OWNER from "@salesforce/schema/ToDo__c.OwnerId";


export default class ModalWindowView extends LightningElement {

    @api recordId;

    fields = [
        NAME_FIELD,
        DESCRIPTION_FIELD,
        CATEGORY_FIELD,
        PRIORITY_FIELD,
        STATUS_FIELD,
        OWNER
    ];

    closeModal(){
        this.dispatchEvent(new CustomEvent('close'));
    }
}
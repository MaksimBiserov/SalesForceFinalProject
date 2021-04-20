import { LightningElement, api } from 'lwc';

import NAME_FIELD from "@salesforce/schema/ToDo__c.Name";
import DESCRIPTION_FIELD from "@salesforce/schema/ToDo__c.Description__c";
import CATEGORY_FIELD from "@salesforce/schema/ToDo__c.Category__c";
import STATUS_FIELD from "@salesforce/schema/ToDo__c.Status__c";
import PRIORITY_FIELD from "@salesforce/schema/ToDo__c.Priority__c";

export default class ModalWindowEdit extends LightningElement {

    @api recordId;

    fields = [
        NAME_FIELD,
        DESCRIPTION_FIELD,
        CATEGORY_FIELD,
        PRIORITY_FIELD,
        STATUS_FIELD
    ];

    closeModal() {
        this.dispatchEvent(new CustomEvent('close'));
    }

    assignToMe(){
        this.dispatchEvent(new CustomEvent('assigntome', {detail: this.recordId}));
    }

    assignToToday(){
        this.dispatchEvent(new CustomEvent('assigntotoday', {detail: this.recordId}));
    }

    assignToTomorrow(){
        this.dispatchEvent(new CustomEvent('assigntotomorrow', {detail: this.recordId}));
    }

    assignToLater(){
        this.dispatchEvent(new CustomEvent('assigntolater', {detail: this.recordId}));
    }

    handleDelete(){
        this.closeModal();
        this.dispatchEvent(new CustomEvent('delete', {detail: this.recordId}));
    }
}
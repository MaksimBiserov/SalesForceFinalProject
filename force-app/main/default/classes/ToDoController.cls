public with sharing class ToDoController {

    List<ToDo__c> getToDos(){
        return [SELECT Id, Name, Creation_Date__c FROM ToDo__c];
    }
}
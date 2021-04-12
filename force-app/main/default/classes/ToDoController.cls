public with sharing class ToDoController {

    List<ToDo__c> getToDos(){
        return [SELECT Id, Name FROM ToDo__c];
    }
}

public with sharing class CleanOldTodo implements Database.Batchable<ToDo__c> {
    public List<ToDo__c> start(Database.BatchableContext param1) {
        Date NintyDaysAgo = [SELECT DataClear__c FROM CleanToDoList__mdt][0].DataClear__c;
        return [SELECT Id, CreatedDate FROM ToDo__c WHERE CreatedDate < :NintyDaysAgo];
    }
    public void execute(Database.BatchableContext param1, List<ToDo__c> oldTodos) {
        delete oldTodos;
    }

    public void finish(Database.BatchableContext param1) {
    }
}
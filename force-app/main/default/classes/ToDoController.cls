public with sharing class ToDoController {

    @AuraEnabled(Cacheable=true)
    public static List<ToDo__c> getToDos(){
        return [
                SELECT Id, Name, Description__c, Creation_Date__c, Status__c, Category__c, Priority__c, OwnerId,
                    (SELECT Name, Status__c FROM Sub_ToDos__r) 
                FROM ToDo__c
                ];
    }

    @AuraEnabled(Cacheable=true)
    public static List<ToDo__c> searchToDos(String searchKey) {
        return [
                SELECT Id, Name, Creation_Date__c
                FROM ToDo__c
                WHERE Name LIKE: '%' + searchKey + '%'
                ORDER BY Category__c
                ];
    }

    @AuraEnabled(Cacheable=true)
    public static List<ToDo__c> getToDosById(String todoId){
        return [
                SELECT Id, Name, Creation_Date__c
                FROM ToDo__c
                WHERE Id =: todoId
                ];
    }

    @AuraEnabled
    public static List<ToDo__c> getToDoQueueById(Id queueId){
        List<ToDo__c> output;
        try {
            output = [SELECT Id, Name, Description__c, Creation_Date__c, Status__c, Category__c, Priority__c, 
                            (SELECT Name, Status__c FROM Sub_ToDos__r) 
                      FROM ToDo__c
                      WHERE OwnerId = :queueId];
            return output;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
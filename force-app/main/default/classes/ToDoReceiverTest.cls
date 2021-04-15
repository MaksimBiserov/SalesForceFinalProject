@isTest
private class ToDoReceiverTest {

    static ToDo__c createRecord() {
        ToDo__c testTodo = new ToDo__c(Name = 'Test01',
                                       Category__c = 'Today',
                                       ExternalId__c = 'a010900000nVG0NAAW');
        insert testTodo;
        return testTodo;
    }

    @IsTest
    static void testCreateTodo() {
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf(
            '[ { "category" : "Today", "name" : "Test01", "id" : "a010900000nVG0NAAW" } ]'
            );
        RestContext.request = request;
        List<Id> ids = ToDoReceiver.createTodo();
        System.assert(ids != null);
        List<ToDo__c> todos = [SELECT Name FROM ToDo__c WHERE Id IN :ids];
        System.assert(todos.size() == 1);
        System.assertEquals(todos.get(0).Name, 'Test01');
    }

    @IsTest
    static void testUpdateTodo() {
        ToDo__c todo = createRecord();
        System.assert(todo != null);
        System.assertEquals(todo.Name, 'Test01');
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf('[{"name": "Test02", "id":"' + todo.ExternalId__c + '"}]');
        RestContext.request = request;
        List<Id> ids = ToDoReceiver.updateTodo();
        System.assert(ids != null);
        ToDo__c updatedTodo = [SELECT Id, Name FROM ToDo__c WHERE Id = :todo.Id];
        System.assert(updatedTodo != null);
        System.assertEquals(updatedTodo.Name, 'Test02');
    }

    @IsTest
    static void testDeleteTodo() {
        List<Id> ids = new List<Id>();
        ids.add(createRecord().ExternalId__c);
        ids.add(createRecord().ExternalId__c);
        ids.add(createRecord().ExternalId__c);
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf(JSON.serialize(ids));
        RestContext.request = request;
        List<ToDo__c> todos = [SELECT Id FROM ToDo__c];
        System.assert(todos.size() == 3);
        List<Id> deletedIds = ToDoReceiver.deleteTodo();
        System.assert(deletedIds != null);
        List<ToDo__c> deletedTodos = [SELECT Id FROM ToDo__c];
        System.assert(deletedTodos.size() == 0);
    }
}
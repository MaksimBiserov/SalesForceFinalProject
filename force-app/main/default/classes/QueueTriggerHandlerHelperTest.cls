@isTest
private class QueueTriggerHandlerHelperTest {
    static ToDo__c createRecord(String name, String recId) {
        return new ToDo__c(
        	Name = name,
            Status__c = false,
            RecordTypeId = recId
        );
    }
    @isTest static void testAssignmentQueue() {
        Group queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Today ToDos'];
        ToDo__c todo = createRecord('Test1', '012090000006M9QAAU');
        System.debug('todo: ' + todo);
        System.debug('todo.RecID: ' + todo.RecordTypeId);
        List<ToDo__c> todos1 = new List<ToDo__c>();
        todos1.add(todo);
        System.debug('todos1: ' + todos1);
        QueueTriggerHandlerHelper.assignmentQueue(todos1);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Tomorrow ToDos'];
        todo = createRecord('Test2', '012090000006M9VAAU');
        System.debug('todo: ' + todo);
        List<ToDo__c> todos2 = new List<ToDo__c>();
        todos2.add(todo);
        System.debug('todos2: ' + todos2);
        QueueTriggerHandlerHelper.assignmentQueue(todos2);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Later ToDos'];
        todo = createRecord('Test3', '012090000006M9aAAE');
        System.debug('todo: ' + todo);
        List<ToDo__c> todos3 = new List<ToDo__c>();
        todos3.add(todo);
        System.debug('todos3: ' + todos3);
        QueueTriggerHandlerHelper.assignmentQueue(todos3);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
    }
}
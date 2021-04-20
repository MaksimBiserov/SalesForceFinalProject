@isTest
private class QueueTriggerHandlerHelperTest {
    static ToDo__c createRecord(String name, String recName) {
        return new ToDo__c(
        	Name = name,
            Status__c = false,
            RecordType = [SELECT Id, Name FROM RecordType WHERE Name =: recName][0]
        );
    }
    @isTest static void testAssignmentQueue() {
        Test.startTest();
        Group queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Today ToDos'];
        ToDo__c todo = createRecord('Test1', 'Today');
        List<ToDo__c> todos1 = new List<ToDo__c>();
        todos1.add(todo);
        QueueTriggerHandlerHelper.assignmentQueue(todos1);
        Test.stopTest();
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
        Test.startTest();
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Tomorrow ToDos'];
        todo = createRecord('Test2', 'Tomorrow');
        List<ToDo__c> todos2 = new List<ToDo__c>();
        todos2.add(todo);
        QueueTriggerHandlerHelper.assignmentQueue(todos2);
        Test.stopTest();
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
        Test.startTest();
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Later ToDos'];
        todo = createRecord('Test3', 'Later');
        List<ToDo__c> todos3 = new List<ToDo__c>();
        todos3.add(todo);
        QueueTriggerHandlerHelper.assignmentQueue(todos3);
        Test.stopTest();
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
    }
}
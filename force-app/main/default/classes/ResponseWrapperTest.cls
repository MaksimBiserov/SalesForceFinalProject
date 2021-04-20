@IsTest
private class ResponseWrapperTest {
    public static ToDo__c todo = new ToDo__c(
        Id = 'a0009000007RU4WAAW',
        Name = 'Test01',
        Description__c = 'Test',
        Category__c = 'Today',
        Priority__c = 'High',
        Status__c = false
    );

    @IsTest
    static void testDoMapping() {
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.id = todo.Id;
        wrapper.name = todo.Name;
        wrapper.description = todo.Description__c;
        wrapper.category = todo.Category__c;
        wrapper.priority = todo.Priority__c;
        wrapper.status = todo.Status__c;

        Test.startTest();
        ResponseWrapper newWrapper = ResponseWrapper.doMapping(todo);
        Test.stopTest();

        System.assertEquals(wrapper.id, newWrapper.id);
        System.assertEquals(wrapper.name, newWrapper.name);
        System.assertEquals(wrapper.description, newWrapper.description);
        System.assertEquals(wrapper.category, newWrapper.category);
        System.assertEquals(wrapper.priority, newWrapper.priority);
        System.assertEquals(wrapper.status, newWrapper.status);
    }

    @IsTest
    static void testdoMappingToWrappers() {
        ResponseWrapper wrapper = new ResponseWrapper();
        wrapper.id = todo.Id;
        wrapper.name = todo.Name;
        wrapper.description = todo.Description__c;
        wrapper.category = todo.Category__c;
        wrapper.priority = todo.Priority__c;
        wrapper.status = todo.Status__c;

        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);

        Test.startTest();
        List<ResponseWrapper> wrappers = ResponseWrapper.doMappingToWrappers(todos);
        Test.stopTest();

        for (ResponseWrapper newWrapper : wrappers) {
            System.assertEquals(wrapper.id, newWrapper.id);
            System.assertEquals(wrapper.name, newWrapper.name);
            System.assertEquals(wrapper.description, newWrapper.description);
            System.assertEquals(wrapper.category, newWrapper.category);
            System.assertEquals(wrapper.priority, newWrapper.priority);
            System.assertEquals(wrapper.status, newWrapper.status);
        }
    }
}
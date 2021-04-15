@RestResource(UrlMapping='/ToDo__c/*')

global with sharing class ToDoReceiver {
    @HttpPost
    global static List<Id> createTodo() {
        RestRequest request = RestContext.request;
        List<Object> deserializedTodos = (List<Object>)JSON.deserializeUntyped(request.requestBody.toString());
        List<ToDo__c> todos = new List<ToDo__c>();
        List<Id> ids = new List<Id>();

        for(Object todo : deserializedTodos) {
            Map<String, Object> todoAdd = (Map<String, Object>)todo;
            todos.add(doCustom(todoAdd));
        }

        insert todos;

        for(ToDo__c todo : todos) {
            ids.add(todo.Id);
            System.debug(todo);
        }

        return ids;
    }

    @HttpPut
    global static List<Id> updateTodo() {
        RestRequest request = RestContext.request;
        List<Object> deserializedTodos = (List<Object>)JSON.deserializeUntyped(request.requestBody.toString());
        List<ToDo__c> todos = new List<ToDo__c>();
        List<Id> ids = new List<Id>();

        for (Object todo : deserializedTodos) {
            Map<String, Object> todoAdd = (Map<String, Object>)todo;
            todos.add(doCustom(todoAdd));
        }

        for(ToDo__c todo : todos) {
            ids.add(todo.ExternalId__c);
            System.debug(todo);
        }

        List<ToDo__c> sourceTodos = [SELECT Id, ExternalId__c FROM ToDo__c WHERE ExternalId__c IN : ids];
        for (ToDo__c todo : todos) {
            for (ToDo__c dataTodo : sourceTodos) {
                if (todo.ExternalId__c == dataTodo.ExternalId__c) {
                    todo.Id = dataTodo.Id;
                }
            }
        }

        update todos;
        return ids;
    }

    @HttpDelete
    global static List<Id> deleteTodo() {
        RestRequest request = RestContext.request;
        List<String> ids = (List<String>)JSON.deserialize(request.requestBody.toString(), List<String>.class);
        List<ToDo__c> todos = [SELECT Id FROM ToDo__c WHERE ExternalId__c IN : ids];

        for (ToDo__c todo : todos) {
            System.debug(todo);
        }

        delete todos;
        return ids;
    }

    private static ToDo__c doCustom(Map<String, Object> todo) {
        return new ToDo__c(
            Name = (String)todo.get('name'),
            Description__c = (String)todo.get('description'),
            Category__c = (String)todo.get('category'),
            Priority__c = (String)todo.get('priority'),
            ExternalId__c = (String)todo.get('id')
        );
    }
}
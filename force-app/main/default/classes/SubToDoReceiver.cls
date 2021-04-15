@RestResource(UrlMapping='/Sub_ToDo__c/*')

global with sharing class SubToDoReceiver {
    @HttpPost
    global static List<Id> createSub() {
        RestRequest request = RestContext.request;
        List<Object> deserializedSubs = (List<Object>) JSON.deserializeUntyped(request.requestBody.toString());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        List<Id> ids = new List<Id>();
        List<Id> externalIds = new List<Id>();

        for (Object sub : deserializedSubs) {
            Map<String, Object> subAdd = (Map<String, Object>)sub;
            subs.add(doCustom(subAdd, externalIds));
        }

        List<ToDo__c> todos = [SELECT Id, ExternalId__c FROM ToDo__c WHERE ExternalId__c IN : externalIds];
        System.debug(todos);

        for (Sub_ToDo__c sub : subs) {
            for (ToDo__c todo : todos) {
                if (sub.ToDo__c == todo.ExternalId__c) {
                    sub.ToDo__c = todo.Id;
                }
            }
        }

        insert subs;

        for (Sub_ToDo__c sub : subs) {
            ids.add(sub.Id);
            System.debug(sub);
        }

        return ids;
    }

    @HttpPut
    global static List<Id> updateSub() {
        RestRequest request = RestContext.request;
        List<Object> deserializedSubs = (List<Object>) JSON.deserializeUntyped(request.requestBody.toString());
        List<Sub_ToDo__c> subs = new List<Sub_ToDo__c>();
        List<Id> externalIds = new List<Id>();
        
        for (Object sub : deserializedSubs) {
            Map<String, Object> subAdd = (Map<String, Object>)sub;
            subs.add(doCustom(subAdd, new List<Id>()));
        }
        
        for (Sub_ToDo__c sub : subs) {
            externalIds.add(sub.External_Id__c);
        }

        List<Sub_ToDo__c> sourceSubs = [SELECT Id, External_Id__c, ToDo__r.Id FROM Sub_ToDo__c WHERE External_Id__c IN :externalIds];

        for (Sub_ToDo__c sub : subs) {
            for (Sub_ToDo__c sourceSub : sourceSubs) {
                if (sub.External_Id__c == sourceSub.External_Id__c) {
                    sub.Id = sourceSub.Id;
                    sub.ToDo__r = sourceSub.ToDo__r;
                }
            }
        }

        update subs;
        return externalIds;
    }

    @HttpDelete
    global static List<Id> deleteSub() {
        RestRequest request = RestContext.request;
        List<String> ids = (List<String>) JSON.deserialize(request.requestBody.toString(), List<String>.class);
        List<Sub_ToDo__c> subs = [SELECT Id FROM Sub_ToDo__c WHERE External_Id__c IN :ids];

        for (Sub_ToDo__c sub : subs) {
            System.debug(sub);
        }

        delete subs;
        return ids;
    }

    private static Sub_ToDo__c doCustom(Map<String, Object> sub, List<Id> subIds) {
        subIds.add((Id)sub.get('relatedTodo'));

        return new Sub_ToDo__c(
            Name = (String)sub.get('name'),
            ToDo__c = (Id)sub.get('relatedTodo'),
            External_Id__c = (Id)sub.get('id')
        );
    }
}
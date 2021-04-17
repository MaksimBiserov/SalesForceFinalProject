public with sharing class ResponseWrapperSub {
    public String id { get; set; }
    public String name { get; set; }
    public Boolean status { get; set; }
    public String relatedTodo { get; set; }

    public static ResponseWrapperSub doMapping(Sub_ToDo__c sub) {
        ResponseWrapperSub wrapper = new ResponseWrapperSub();
        wrapper.id = sub.Id;
        wrapper.name = sub.Name;
        wrapper.status = sub.Status__c;
        wrapper.relatedTodo = sub.ToDo__c;
        return wrapper;
    }

    public static List<Id> doMappingToIds(List<Sub_ToDo__c> subs){
        List<Id> ids = new List<Id>();

        for (Sub_ToDo__c sub: subs) {
            ids.add(sub.Id);
        }

        return ids;
    }

    public static List<ResponseWrapperSub> doMappingToWrappers(List<Sub_ToDo__c> subs){
        List<ResponseWrapperSub> wrappers = new List<ResponseWrapperSub>();

        for (Sub_ToDo__c sub: subs) {
            ResponseWrapperSub wrapper = doMapping(sub);
            wrappers.add(wrapper);
        }

        return wrappers;
    }
}
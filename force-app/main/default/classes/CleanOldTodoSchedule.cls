global class CleanOldTodoSchedule implements Schedulable {
    global void execute(SchedulableContext ctx) {
        CleanOldTodo cleanTodo = new CleanOldTodo();
        Database.executeBatch(cleanTodo);
    }
}
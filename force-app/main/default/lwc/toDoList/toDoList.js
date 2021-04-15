import { LightningElement, wire } from 'lwc';
import getToDos from '@salesforce/apex/ToDoController.getToDos';

export default class ToDoList extends LightningElement {
    @wire(getToDos) todos;

    logTodos(){
        console.log('click');
        console.log(this.todos);
    }
}
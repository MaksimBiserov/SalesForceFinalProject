import { LightningElement, api } from 'lwc';

export default class ToDoItem extends LightningElement {

    @api todo;

    handleEdit(event){
        this.dispatchEvent(new CustomEvent('edit', {detail: this.todo.Id}));
    }

    handleView(event){
        this.dispatchEvent(new CustomEvent('view', {detail: this.todo.Id}));
    }
}
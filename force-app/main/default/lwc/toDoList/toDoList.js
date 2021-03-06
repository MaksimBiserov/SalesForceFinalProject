import { LightningElement, track, wire } from 'lwc';
import getToDos from '@salesforce/apex/ToDoController.getToDos';
import Id from '@salesforce/user/Id';
import { refreshApex } from '@salesforce/apex';
import {updateRecord, deleteRecord, getRecord} from 'lightning/uiRecordApi';


export default class ToDoList extends LightningElement {

    TodayId = "00G09000000O0XZEA0";
    TomorrowId = "00G09000000O0XeEAK";
    LaterId = "00G09000000O0XjEAK";
    todo;

    showCreateModal = false;
    showEditModal = false;
    showViewModal = false;

    isSearching = false;

    @track searchingTodos;

    @wire(getToDos)
    todos;

    get filteredMyTodos() {

        if(this.isSearching){
            return this.searchingTodos.filter(item => item.OwnerId == Id && item.Status__c == false);
        }

        if(this.todos.data){
            return this.todos.data.filter(item => item.OwnerId == Id && item.Status__c == false);
        }
    }
    get filteredTodayTodos() {

        if(this.isSearching){
            return this.searchingTodos.filter(item => item.OwnerId == this.TodayId);
        }

        if(this.todos.data){
            return this.todos.data.filter(item => item.OwnerId == this.TodayId);
        }
    }
    get filteredTomorrowTodos() {

        if(this.isSearching){
            return this.searchingTodos.filter(item => item.OwnerId == this.TomorrowId);
        }

        if(this.todos.data){
            return this.todos.data.filter(item => item.OwnerId == this.TomorrowId);
        }
    }
    get filteredLaterTodos() {

        if(this.isSearching){
            return this.searchingTodos.filter(item => item.OwnerId == this.LaterId);
        }

        if(this.todos.data){
            return this.todos.data.filter(item => item.OwnerId == this.LaterId);
        }
    }
    get filteredDoneTodos() {

        if(this.isSearching){
            return this.searchingTodos.filter(item => item.OwnerId == Id && item.Status__c == true);
        }

        if(this.todos.data){
            return this.todos.data.filter(item => item.OwnerId == Id && item.Status__c == true);
        }
    }

    showCreateModalWindow(){
        this.showCreateModal = true;
    }

    closeCreateModalWindow(){
        this.showCreateModal = false;
        refreshApex(this.todos);
    }

    handleEdit(event){
        this.todo = event.detail;
        this.showEditModal = true;
    }

    closeEditModalWindow(){
        this.showEditModal = false;
        refreshApex(this.todos);
    }

    handleView(event){
        this.todo = event.detail;
        this.showViewModal = true;
    }

    closeViewModalWindow(){
        this.showViewModal = false;
        refreshApex(this.todos);
    }

    async handleAssignToMe(event){
        let fields = {
            Id: event.detail,
            OwnerId: Id
        }
        const recordInput = { fields };

        await updateRecord(recordInput);

        refreshApex(this.todos);
    }

    async handleAssignToToday(event){
        let fields = {
            Id: event.detail,
            OwnerId: this.TodayId
        }
        const recordInput = { fields };

        await updateRecord(recordInput);

        refreshApex(this.todos);
    }

    async handleAssignToTomorrow(event){
        let fields = {
            Id: event.detail,
            OwnerId: this.TomorrowId
        }
        const recordInput = { fields };

        await updateRecord(recordInput);

        refreshApex(this.todos);
    }

    async handleAssignToLater(event){
        let fields = {
            Id: event.detail,
            OwnerId: this.LaterId
        }
        const recordInput = { fields };

        await updateRecord(recordInput);

        refreshApex(this.todos);
    }

    async handleDelete(event){
        await deleteRecord(event.detail);
        refreshApex(this.todos);
    }


    search(event){
        let value = event.target.value;

        this.isSearching = value ? true : false;

        this.searchingTodos = this.todos.data.filter(item => item.Name.toLowerCase().includes(value.toLowerCase()));
    }

    async update(event){
        let fields = {
            Id: event.detail.Id,
        }
        const recordInput = { fields };

        await updateRecord(recordInput);

        await refreshApex(this.todos);

        this.todo = this.todos.data.filter(item => item.Id == event.detail.Id)[0];
    }
}
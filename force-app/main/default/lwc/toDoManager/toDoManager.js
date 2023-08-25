import { LightningElement, track, wire } from 'lwc';
import createTasks from '@salesforce/apex/ToDoApexClass.createTasks';
import gettasksRecords from '@salesforce/apex/ToDoApexClass.gettasksRecords';
import updateTasksRecord from '@salesforce/apex/ToDoApexClass.updateTasksRecord';
import completedTasks from '@salesforce/apex/ToDoApexClass.completedTasks';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

export default class ToDoManager extends LightningElement {


    time;
    greetings;
    // how to get Current Time From Client Side Server

    getTime(){
        const date = new Date();
        const hour = date.getHours();
        const min = date.getMinutes();

        // once set all below thing then you have to write time value store in time property

        this.time = `${this.getHour(hour)} : ${this.getTwoDigitsValue(min)}  ${this.getMidday(hour)}`;
        this.setGreetings(hour);
    }

    // get hour values in 12 hours format by using ecma script format in JS

    getHour(hour){
        return hour === 0 ? 12 : hour > 12 ? (hour - 12) : hour; // here we are checking condition and giving 12 hours format only based on condition
    }

    getMidday(hour){
        return hour >= 12 ? "PM" : "AM"; // here we are checking if >=12 then need to come and display PM otherwise AM
    }

    getTwoDigitsValue(digit){
        return digit <10 ? "0"+ digit : digit; // here we are checking condition and need to display two digits value for minutes
    }


    // after completeting all above things set Greetings

    setGreetings(hour){
        if(hour<12){
            this.greetings = "Good Morning";
        } else if(hour>=12 && hour<16){
            this.greetings = "Good After Noon";
        } else if(hour >=16 && hour <19){
            this.greetings = "Good Evening";
        } else {
            this.greetings = "Good Night";
        }
    }


    // once set all those things these all functions so we have to call connected call back these two functions

    connectedCallback() {
        // why we are using setInterval is with out refreshing the page current time need to display so that based on with the help of that one we could possible that one
        setInterval(()=>{
            this.getTime();
        }, 5000)
    }

    // create task record by using based on input value

    @track inputValue;
    // in this handleChange will get the whatever giving value by using and we have to pass the value to above mentioned property
    inputHandleChange(event){
        this.inputValue = event.target.value; // here we are storing run time what we are creating or giving inpit values store inside the property
    }

    // for storing whatever given or created date we need one property and also while we are performing any DML opearation we have to do by using imperative method
        tasks;
    addToDoHandler(){
        createTasks({taskName : this.inputValue})
        .then(result=>{
            refreshApex(this.taskData); // why are using means once the task has been created need to display all tasks record with out refreshing page and also which tasks has not been completed task records only
            console.log('result', result);
        }).catch(error=>{
            console.log('error', error);
        })
    }

    // for displaying all created task records we have get the all data by using wire

    // for storing all data what we are getting from apex we need one Property

    @track taskData; // in this propery all data stored errors and data
    @wire(gettasksRecords)
    getTasksRecordsFunction(result){
        this.taskData = result;
        if(result.data){
            this.tasks = result.data // in this we are storing only record data only
        } else if(result.error){
            console.log('error', result.error);
        }
    }

    // update the task for complete the task

    updateHandleClick(event){
        const myRecordId  = event.target.dataset.id;
        console.log('myRecordId', myRecordId);
        updateTasksRecord({selectedRecordId : myRecordId})
        .then(result=>{
            refreshApex(this.allCmpTasksData); // here why we have to do using means once task has been completed in completed list with out refreshing page  need to display completed task records 
            refreshApex(this.taskData); // here why we are using once the task has been completed that task record with out refrshing page need to remove  from task todo Records
            console.log('result', result);
        }).catch(error=>{
            console.log('error', error);
        })
    }

    // we need to get all completed tasks data by using wire , and for storing total data for one property and only record data for another property
    cmpTasks;
    allCmpTasksData
    @wire(completedTasks)
    completedTasksFunction(result){
        this.allCmpTasksData = result; // here we are storing all data adn error 
        if(result.data){
            this.cmpTasks = result.data; // here we are storing only records
            console.log('this.cmpTasks', this.cmpTasks);
        } else if(result.error){
            console.log('result.error', result.error);
        }
    }

    // for deleting task record we have to write and store one property

    deleteHandleClick(event){
        const deletedRecordId = event.target.dataset.id;
        deleteRecord(deletedRecordId)
        .then(()=>{
            refreshApex(this.taskData);
            console.log('deleted successfully');
        }).catch(error=>{
            console.log('error : record has been not deleted', error);
        })
    }
}
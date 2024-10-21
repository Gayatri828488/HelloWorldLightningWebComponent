import { LightningElement } from 'lwc';

export default class LifeCycleHooks extends LightningElement {
    constructor(){
       super();
        console.log('this is my LifeCycleHookconstructor method');

    }
    connectedCallback(){
        // this.classList.add("new-class");
        console.log('this is my LifeCycleHookscallback method');
    }
}
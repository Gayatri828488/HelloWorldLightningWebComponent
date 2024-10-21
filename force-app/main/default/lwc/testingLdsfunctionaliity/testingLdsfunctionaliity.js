// import { LightningElement } from 'lwc';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import ACCOUNT_OBJECT from '@salesforce/schema/Account';
// import NAME_FIELD from '@salesforce/schema/Account.Name';
// import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
// import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
// import Name from '@salesforce/schema/Account.Name';
// export default class AccountCreator extends LightningElement {
//     objectApiName = ACCOUNT_OBJECT;
//     fields = [NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];
//     handleSuccess(event) {
//         const toastEvent = new ShowToastEvent({
//             title: "Account created",
//             message: "Record ID: " + event.detail.id,
//             variant: "success"
//         });
//         this.dispatchEvent(toastEvent);
//     }
//     connectedCallback(){
//         console.log( ' name feild :', NAME_FIELD);
//     }

// }
// import { LightningElement, api, wire } from 'lwc';
// import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
// import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
// export default class TestingLdsFunctionaliity extends LightningElement {
//     @api recordId;
//     @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD] })
//     account;
//     get name() {
//         return getFieldValue(this.account.data, ACCOUNT_NAME_FIELD);
//     }
// connectedCallback(){
//     console.log('getRecord',getRecord);
//     console.log('ACCOUNT_NAME_FIELD ',ACCOUNT_NAME_FIELD );
//     console.log('getFieldValue',getFieldValue);
//     console.log('this.account',this.account);
//     console.log('this.wire',this.wire);
    
    
    
    

// }
// }













// import { LightningElement , api} from 'lwc';
// import NAME_FIELD from '@salesforce/schema/Contact.Name';
//     import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

   

// export default class TestingLdsfunctionaliity extends LightningElement {
//     nameField = NAME_FIELD;
//     phoneField = PHONE_FIELD;
    
    

//         @api objectApiName;
//         @api recordId;
    

// }

 

// import { LightningElement, api, wire } from "lwc";
// import { getFieldValue, getRecord } from "lightning/uiRecordApi";
// import Account_Name from '@salesforce/schema/Account.Name';
// import Industry from "@salesforce/schema/Account.Industry";

// export default class TestingLdsFunctionality extends LightningElement {
//     @api recordId;

//     fields = [];
//     @wire(getRecord, { recordId: '$recordId', fields: [Account_Name, Industry] })
//     account;

//      get name() {
//     //     if(this.account.data) {
//     //         this.fields = account.data;
//     //     } else {
//     //         return '';
//     //     }
//          return this.account.data ? getFieldValue(this.account.data, Account_Name) : '';
//     }

//     get industry() {
//         return this.account.data ? getFieldValue(this.account.data, Industry) : '';
//     }
// get fields(){
//     return  [this.industry ,this.name];
// }
// }

import { LightningElement, api, wire } from "lwc";
import { getFieldValue, getRecord } from "lightning/uiRecordApi";
import Account_Name from '@salesforce/schema/Account.Name';
import Industry from "@salesforce/schema/Account.Industry";

export default class TestingLdsFunctionality extends LightningElement {
    @api recordId;
    objectApiName = 'Account';  // Define the object API name

    fields = [Account_Name.fieldApiName, Industry.fieldApiName]; // Use API names directly
    @wire(getRecord, { recordId: '$recordId', fields: [Account_Name, Industry] })
    account;

    get name() {
        return this.account.data ? getFieldValue(this.account.data, Account_Name) : '';
    console.log(this.account.data);
    }

    get industry() {
        return this.account.data ? getFieldValue(this.account.data, Industry) : '';
   console.log(this.account.data);
   
    }
}


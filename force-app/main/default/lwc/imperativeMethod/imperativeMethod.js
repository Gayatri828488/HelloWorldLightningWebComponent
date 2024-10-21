// import { LightningElement, track, wire } from 'lwc';
// import getContacts from '@salesforce/apex/ImperativeMethod.getContacts';

// // const columns = [
// //     { label: 'Id', fieldName: 'AccountId' },
// //     { label: 'Last Name', fieldName: 'LastName' }
// // ];

// export default class ImperativeMethod extends LightningElement {
//     // @track columns = columns;
//     // @track data = [];
//     @track showData = false; // Controls visibility of data
//     @track changeTitle = 'Show';
//     @track  conData = [];
//     @track options = [];
//     @track value ;



//     changeHandler(event) {
//         this.showData = !this.showData; // Toggle showData
//         this.changeTitle = this.showData ? 'Hide' : 'Show'; // Update button label
//     }

//     @wire(getContacts)
//     wirecontact({error , data}){
//         if(data){
//             this.condata = data ;
//             this.options  = data.map(contact => {
//                 return { label: contact.LastName, value: contact.AccountId };
//             });
//         }
//         else if(error) {
//   console.error(error.message);
  
//         }

    

//     }
//     changeHandler(event){
//         this.value =  event.detail.value;
//     }

// }
// import { LightningElement, track, wire } from 'lwc';
// import getContacts from '@salesforce/apex/ImperativeMethod.getContacts';

// export default class ImperativeMethod extends LightningElement {
//     @track showData = false; // Controls visibility of data
//     @track changeTitle = 'Show';
//     @track conData = []; // Data for contacts
//     @track options = [];
//     @track value;

//     // Combined changeHandler to manage both button toggle and combobox change
//     changeHandler(event) {
//         if (event.target.label === this.changeTitle) {
//             this.showData = !this.showData; // Toggle showData
//             this.changeTitle = this.showData ? 'Hide' : 'Show'; // Update button label
//         } else {
//             this.value = event.detail.value; // Update selected value
//         }
//     }

//     @wire(getContacts)
//     wirecontact({ error, data }) {
//         if (data) {
//             this.conData = data;
//             this.options = data.map(contact => {
//                 return { label: contact.LastName, value: contact.AccountId };
//             });
//         } else if (error) {
//             console.error(error.message);
//         }
//     }
// }



import { LightningElement, track, wire} from 'lwc';
import getAccount from '@salesforce/apex/ImperativeMethod.getAccount';
import getContact from '@salesforce/apex/ImperativeMethod.getContact';
columns = [{label :ContactLastName, Field : LastName},
    {label: ContactEmail, Field:Email }];
          
export default class ImperativeMethod extends LightningElement {
    @track showData = false; // Controls visibility of data
    @track changeTitle = 'Show';
    @track conData = []; // Data for contacts
    @track options = [];
    @track value  = "";
    @track error = "";
    column = columns;

    changeHandler(event) {
        if (event.target.label === this.changeTitle) {
            this.showData = !this.showData; // Toggle showData
            this.changeTitle = this.showData ? 'Hide' : 'Show'; // Update button label
        } else {
            this.value = event.detail.value; // Update selected value
        }
    }

    @wire(getAccount)
    wireContact({ error, data }) {
        if (data) {
            console.log(data);
            
            this.conData = data;
            this.options = data.map(Account => ({
               label: Account.Name, 
                value: Account.Id // Assuming 'Id' is the unique identifier for contacts
            }));
        } else if (error) {
            this.error = error.detail.message;
            console.error('Error fetching contacts:', error);
        }
    }
   
   
}

